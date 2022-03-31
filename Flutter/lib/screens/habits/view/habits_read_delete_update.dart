import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/common/widgets/selection_collection.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/domain_crud/provider/deleted_notification.dart';
import 'package:digi3map/screens/domain_crud/provider/domain_provider.dart';
import 'package:digi3map/screens/domain_crud/view/add_domain.dart';
import 'package:digi3map/screens/domain_crud/widget/image_picker.dart';
import 'package:digi3map/screens/domain_crud/widget/password_to_delete_domain.dart';
import 'package:digi3map/screens/domain_crud/widget/password_to_delete_habit.dart';
import 'package:digi3map/screens/domain_crud/widget/profile_editable_description_widget.dart';
import 'package:digi3map/screens/domain_crud/widget/profile_heading_editable_widget.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/view/habits_graph.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/widgets/milestone_widget.dart';
import 'package:digi3map/screens/habits/provider/habits_provider.dart';
import 'package:digi3map/screens/habits/widgets/open_chain_navigation_widget.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HabitsReadDeleteUpdate extends StatefulWidget {
  int id;
  HabitsReadDeleteUpdate({required this.id,Key? key}) : super(key: key);

  @override
  State<HabitsReadDeleteUpdate> createState() => _HabitsReadDeleteUpdateState();
}

class _HabitsReadDeleteUpdateState extends State<HabitsReadDeleteUpdate> {
  ValueNotifier<String> domainValue=ValueNotifier("Fitness");

  bool isLoading=true;
  bool isDeleteEditLoading=false;
  bool domainProviderFirst=true;
  bool isLoadingDomainFirst=true;
  ValueNotifier<String> nameValue=ValueNotifier("");



  final ValueNotifier<bool> imageSelectedProvider=ValueNotifier(false);
  ValueNotifier<String> descriptionValue=ValueNotifier("");

  ValueNotifier<String?> imageValue=ValueNotifier(null);
  late ValueNotifier<String> widgetValue;

  late Habit habit;
  int progress=0;

  @override
  void initState() {
    super.initState();
    getValues();
  }
  void getValues() async{
    habit=await HabitsProvider.getHabit(id: widget.id);
    domainValue.value=habit.domainName;
    imageValue.value=habit.photoUrl;
    nameValue.value=habit.name;
    descriptionValue.value=habit.description;
    progress=habit.progress;
    widgetValue=ValueNotifier(habit.widgetType);
    isLoading=false;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(
            create: (context)=>HabitsProvider()
        ),
      ],
      child: SafeArea(
        child:Scaffold(
          body: Container(
            height: size.height,
            width: size.width,
            padding: Constants.kPagePaddingNoDown,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Habits Details",
                  style: Styles.bigHeading,
                ),
                Constants.kSmallBox,
                Expanded(
                  child: isLoading?
                      Center(
                        child: CustomCircularIndicator(),
                      )
                      :SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomImagePicker(fromServer: true,
                            imageLocation: imageValue,
                          imageSelected: imageSelectedProvider,
                        ),
                        Constants.kVerySmallBox,
                        ProfileHeadingEditableWidget(
                          value:nameValue,
                          bigHighlight: true,
                        ),
                        ProfileEditableDescriptionWidget(
                          description: descriptionValue
                        ),
                        Constants.kVerySmallBox,
                        Text(
                          "Domain",
                          style: Styles.opacityHeadingStyle,
                        ),
                        Constants.kVerySmallBox,
                        Consumer<HabitsProvider>(
                            builder: (context,provider,child) {
                              if(isLoadingDomainFirst){
                                provider.getDomain();
                                isLoadingDomainFirst=false;
                              }
                              if(provider.isDomainLoading) {
                                return Center(
                                  child: CustomCircularIndicator(),
                                );
                              }
                              if(provider.domainList.length==0 && provider.addingAllowed==false){
                                return Text(
                                    "Cannot Add, All Domains Are Occupied With 2 Habits"
                                );
                              }
                              print("Domain Value "+domainValue.value);
                              return Wrap(
                                children: [
                                  SelectionCollection(
                                      defaultValue: domainValue.value,
                                      value: domainValue,
                                      valuesList: provider.domainList
                                  ),
                                  provider.addingAllowed?
                                  ElevatedButton(
                                      onPressed: (){
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => AddDomain(
                                              provider: DomainProvider(),
                                            ))).then((value) {
                                          provider.getDomain();
                                        });
                                      },
                                      child: Text(
                                        "Add",
                                      )
                                  ):SizedBox()
                                ],
                              );
                            }
                        ),
                        Constants.kVerySmallBox,
                        Text(
                          "Widget",
                          style: Styles.opacityHeadingStyle,
                        ),
                        Constants.kVerySmallBox,
                        SelectionCollection(
                          defaultValue: widgetValue.value,
                            value: widgetValue,
                            valuesList:Habit.widgetList
                        ),
                        Constants.kVerySmallBox,
                        Consumer<HabitsProvider>(
                          builder: (context,provider,child) {
                            return isDeleteEditLoading?Center(
                              child: CustomCircularIndicator(),
                            ):ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: ColorConstant.kBlueColor),
                                onPressed: (){
                                  setState(() {
                                    isDeleteEditLoading=true;
                                  });
                                  provider.addUpdateHabit(
                                      Habit(
                                        id: habit.id,
                                          domainName: domainValue.value,
                                          name: nameValue.value,
                                          domainId: provider.idCalculator(domainValue.value),
                                          photoUrl: imageValue.value??"",
                                          widgetType: widgetValue.value,
                                          description: descriptionValue.value,
                                          progress: progress
                                      ),
                                      haveNewImage:imageSelectedProvider.value
                                  ).then((value) {
                                    CustomSnackBar.showSnackBar(context, "Successfully Edited");
                                    Navigator.pop(context);

                                  }).onError((error, stackTrace) {
                                    CustomSnackBar.showSnackBar(context, error.toString());
                                    setState(() {
                                      isDeleteEditLoading=false;
                                    });
                                  });
                                },
                                child: const Text('Save')
                            );
                          }
                        ),
                        Constants.kVerySmallBox,
                        Text(
                          "Chain",
                          style: Styles.opacityHeadingStyle,
                        ),
                        Constants.kVerySmallBox,
                        OpenChainNavigationWidget(habitId: habit.id,habitName: habit.name,),
                        Constants.kVerySmallBox,
                        HabitsGraph(),
                        Constants.kSmallBox,
                        Text(
                          "Milestone",
                          style: Styles.opacityHeadingStyle,
                        ),
                        Constants.kVerySmallBox,
                        MileStoneWidget(mileStone: habit.getMilestone(showNavigator: false)),
                        Constants.kVerySmallBox,
                        Constants.kVerySmallBox,
                        Consumer<HabitsProvider>(
                          builder: (context,habitProvider,child) {
                            return isDeleteEditLoading?Center(
                              child: CustomCircularIndicator(),
                            ):ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: Colors.red),
                                onPressed: (){
                                  showPasswordModal(
                                      context: context,
                                      id: habit.id.toString(),
                                    provider: habitProvider
                                  );
                                },
                                child: const Text('Delete')
                            );
                          }
                        ),
                        Constants.kVerySmallBox,

                      ],
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }


  void showPasswordModal({required BuildContext context,required String id,required HabitsProvider provider}){
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
            child: PasswordToDeleteHabit(
              provider: provider,
              id: id,
            ),
          );
        }
    );
  }



}
