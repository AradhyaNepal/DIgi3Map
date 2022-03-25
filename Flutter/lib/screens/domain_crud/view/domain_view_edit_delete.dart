import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/common/widgets/selection_collection.dart';
import 'package:digi3map/common/widgets/selection_unit.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/domain_crud/provider/deleted_notification.dart';
import 'package:digi3map/screens/domain_crud/provider/domain_provider.dart';
import 'package:digi3map/screens/domain_crud/widget/image_picker.dart';
import 'package:digi3map/screens/domain_crud/widget/password_to_delete_domain.dart';
import 'package:digi3map/screens/domain_crud/widget/profile_editable_description_widget.dart';
import 'package:digi3map/screens/domain_crud/widget/profile_heading_editable_widget.dart';
import 'package:digi3map/screens/domain_list_graph/view/domain_graph.dart';
import 'package:digi3map/screens/domain_list_graph/widget/focus_widget.dart';
import 'package:digi3map/screens/fitness_page/view/fitness_edit.dart';
import 'package:digi3map/screens/habits/view/habits_create.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class DomainProfilePage extends StatefulWidget {
  final Domain domain;
  final DomainProvider provider;

  DomainProfilePage({
    required this.domain,
    required this.provider,
    Key? key
  }) : super(key: key);

  @override
  State<DomainProfilePage> createState() => _DomainProfilePageState();
}

class _DomainProfilePageState extends State<DomainProfilePage> {
  bool isLoading=false;
  final ValueNotifier<String> imageValue=ValueNotifier("");

  final ValueNotifier<String> domainName=ValueNotifier("");

  final ValueNotifier<String> domainDescription=ValueNotifier("");

  final ValueNotifier<bool> imageSelectedProvider=ValueNotifier(false);

  final ValueNotifier<String> priority=ValueNotifier("Low");

  final ValueNotifier<String?> pickedImage=ValueNotifier(AssetsLocation.anonymousImageLocation);

  @override
  void initState() {

    imageValue.value=widget.domain.imagePath;
    domainName.value=widget.domain.domainName;
    domainDescription.value=widget.domain.description;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          padding: Constants.kPagePaddingNoDown,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Domain Detail',
                  style: Styles.bigHeading,
                ),
                Constants.kSmallBox,
                CustomImagePicker(imageLocation:imageValue, fromServer: true,imageSelected: imageSelectedProvider,),
                Constants.kVerySmallBox,
                ProfileHeadingEditableWidget(bigHighlight: true,value:domainName,),
                ProfileEditableDescriptionWidget(description: domainDescription,),
                Constants.kSmallBox,
                Text('Priority Value',style: Styles.forgotPasswordStyle,),
                Constants.kVerySmallBox,
                SelectionCollection(
                  valuesList: ['High','Low','Medium'],
                  defaultValue: widget.domain.priority,
                  value: priority,
                ),
                Constants.kSmallBox,
                Text(
                    'Habits (Max 2)',
                  style: Styles.opacityHeadingStyle,
                ),

                Constants.kVerySmallBox,
                FutureBuilder<List<String>>(
                    future: widget.provider.getDomainHabitsList(widget.domain.domainId??0),
                  builder: (context,snapShot) {
                    if(snapShot.connectionState==ConnectionState.waiting) return Center(child: CustomCircularIndicator());
                    bool showAdd=snapShot.data!.length<2;
                    return Wrap(
                      children: [
                        for(String value in snapShot.data!)
                          SelectionUnit(isSelected: true, value: value),
                        showAdd?ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: ColorConstant.kBlueColor),
                            onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>AddHabits(defaultDomain: widget.domain.domainName,)));
                            },
                            child: const Text('Add Habit')
                        ):SizedBox()
                      ],
                    );
                  }
                ),
                Constants.kVerySmallBox,
                Text(
                    'Percentage',
                  style: Styles.opacityHeadingStyle,
                ),
                Constants.kVerySmallBox,
                Card(
                  margin: const EdgeInsets.all(0),
                  child: Row(
                    children: [
                      Expanded(
                        flex:3,
                          child: FocusWidget(
                            percentage: widget.domain.percentage??0,
                          )
                      ),
                      Spacer(),
                      Expanded(
                        flex: 4,
                          child: TextButton(
                            onPressed: (){

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>  DomainGraph()));
                            },
                            child: Text(
                              'Open Graph >>',
                              textAlign: TextAlign.right,
                              style: Styles.blueHighlight,
                            ),
                          )
                      ),
                      SizedBox(width: 10,)
                    ],
                  ),
                ),
                Constants.kSmallBox,
                isLoading?Center(child: CustomCircularIndicator(),):Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: (){

                            showPasswordModal(context:context,id: widget.domain.domainId.toString());
                          },
                          child: const Text('Delete')
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: ColorConstant.kBlueColor),
                          onPressed: (){
                            print("Domain Description ${priority.value}");
                            setState(() {
                              isLoading=true;
                            });
                            widget.provider.addEditDomain(
                                Domain(
                                  domainId: widget.domain.domainId,
                                    imagePath: imageValue.value,
                                    domainName: domainName.value,
                                    description: domainDescription.value,
                                    userId: widget.domain.userId,
                                    priority: priority.value,
                                ),
                              haveNewImage:imageSelectedProvider.value

                            ).then((value) {

                              CustomSnackBar.showSnackBar(context, "Successfully Saved");
                              Navigator.pop(context);
                            }).onError((error, stackTrace) {
                              setState(() {
                                isLoading=false;
                              });
                              CustomSnackBar.showSnackBar(context, error.toString());
                            });
                          },
                          child: const Text('Save')
                      ),
                    )
                  ],
                ),
                Constants.kSmallBox,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showPasswordModal({required BuildContext context,required String id}){
    showDialog(
      barrierDismissible: false,

        context: context,
        builder: (context){
          return NotificationListener<DeletedNotification>(
            onNotification: (value){
              print("Notification");
              CustomSnackBar.showSnackBar(context, "Successfully Deleted");
              Navigator.pop(context);
              return true;
            },
            child: PasswordToDeleteDomain(
              provider: widget.provider,
              id: id,
            ),
          );
        }
    );
  }

}
