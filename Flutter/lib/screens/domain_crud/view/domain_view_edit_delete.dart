import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/common/widgets/selection_collection.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/domain_crud/widget/imagepicker.dart';
import 'package:digi3map/screens/domain_crud/widget/password_to_edit_widget.dart';
import 'package:digi3map/screens/domain_crud/widget/profile_editable_description_widget.dart';
import 'package:digi3map/screens/domain_crud/widget/profile_heading_editable_widget.dart';
import 'package:digi3map/screens/domain_list_graph/widget/focus_widget.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class DomainProfilePage extends StatelessWidget {
  DomainProfilePage({Key? key}) : super(key: key);
  final ValueNotifier<String?> pickedImage=ValueNotifier(AssetsLocation.anonymousImageLocation);

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
                Text(
                  'Domain Detail',
                  style: Styles.bigHeading,
                ),
                Constants.kSmallBox,
                CustomImagePicker(imageLocation: pickedImage),
                Constants.kVerySmallBox,
                ProfileHeadingEditableWidget(),
                ProfileEditableDescriptionWidget(),
                Constants.kMediumBox,
                Text(
                    'Habits (Max 2)',
                  style: Styles.opacityHeadingStyle,
                ),
                Constants.kVerySmallBox,
                Wrap(
                  children: [
                    SelectionCollection(valuesList: ['Fitness']),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: ColorConstant.kBlueColor),
                        onPressed: (){},
                        child: Text('Add Another')
                    )
                  ],
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
                            percentage: 25,
                          )
                      ),
                      Spacer(),
                      Expanded(
                        flex: 4,
                          child: Text(
                            'Open Graph >>',
                            textAlign: TextAlign.right,
                            style: Styles.blueHighlight,
                          )
                      ),
                      SizedBox(width: 10,)
                    ],
                  ),
                ),
                Constants.kSmallBox,
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: (){
                            showPasswordModal(context);
                          },
                          child: Text('Delete')
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: ColorConstant.kBlueColor),
                          onPressed: (){
                            showPasswordModal(context);
                          },
                          child: Text('Save')
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

  void showPasswordModal(BuildContext context){
    showDialog(
        context: context,
        builder: (context){
          return PasswordToEditWidget();
        }
    );
  }
}
