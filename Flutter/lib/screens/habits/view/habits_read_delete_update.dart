import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/common/widgets/selection_collection.dart';
import 'package:digi3map/common/widgets/selection_unit.dart';
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
import 'package:digi3map/screens/homepage/provides/random_provider.dart';
import 'package:digi3map/screens/homepage/provides/selection_notification.dart';
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
  int widgetTypeIndex=0;
  int? time;
  int? sets;
  int? rest;
  ValueNotifier<String> domainValue=ValueNotifier("Fitness");

  bool isLoading=true;
  bool isDeleteEditLoading=false;
  bool domainProviderFirst=true;
  bool isLoadingDomainFirst=true;
  ValueNotifier<String> nameValue=ValueNotifier("");

  final GlobalKey<FormState> formKey=GlobalKey();

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
    sets=habit.sets;
    time=habit.time;
    rest=habit.rest;
    domainValue.value=habit.domainName;
    imageValue.value=habit.photoUrl;
    nameValue.value=habit.name;
    descriptionValue.value=habit.description;
    progress=habit.progress;
    widgetValue=ValueNotifier(habit.widgetType);
    widgetTypeIndex=RandomTaskModal.widgetTypeList.indexWhere((element) => element==widgetValue.value);
    if(widgetTypeIndex==-1) widgetTypeIndex=0;
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          "Domain (Unmodifiable)",
                          style: Styles.opacityHeadingStyle,
                        ),
                        Constants.kVerySmallBox,
                        SelectionUnit(
                            isSelected: true,
                            value: domainValue.value
                        ),
                        Constants.kVerySmallBox,
                        Text(
                          "Widget",
                          style: Styles.opacityHeadingStyle,
                        ),
                        Constants.kVerySmallBox,
                        NotificationListener<SelectionNotification>(
                          onNotification: (value){
                            setState(() {
                              widgetTypeIndex=value.index;
                            });
                            return true;
                          },
                          child: SelectionCollection(
                            defaultValue: RandomTaskModal.widgetTypeList[widgetTypeIndex],
                              value: widgetValue,
                              valuesList:RandomTaskModal.widgetTypeList
                          ),
                        ),
                        Constants.kSmallBox,
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              (widgetTypeIndex==2 || widgetTypeIndex==3)?Column(
                                children: [
                                  TextFormField(
                                      initialValue: sets!=null?sets.toString():null,
                                      validator: (value){
                                        if(value!.isEmpty) return "Please Enter Sets";
                                        return null;
                                      },
                                      onSaved: (value){
                                        try{
                                          sets=int.parse(value!);
                                        }catch (e){

                                        }
                                      },

                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      decoration:Styles.getDecorationWithLable("Sets")
                                  ),
                                  Constants.kSmallBox,
                                ],
                              ):SizedBox(),


                              (widgetTypeIndex==2 || widgetTypeIndex==3)?Column(
                                children: [
                                  TextFormField(
                                      initialValue: rest!=null?rest.toString():null,
                                      validator: (value){
                                        if(value!.isEmpty) return "Please Enter Rest Time";
                                        return null;
                                      },
                                      onSaved: (value){
                                        try{
                                          rest=int.parse(value!);
                                        }catch (e){

                                        }
                                      },
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      decoration:Styles.getDecorationWithLable("Rest (Minutes)")
                                  ),
                                  Constants.kSmallBox,
                                ],
                              ):SizedBox(),

                              (widgetTypeIndex==1 || widgetTypeIndex==3)?Column(
                                children: [
                                  TextFormField(
                                      initialValue: time!=null?time.toString():null,
                                      validator: (value){
                                        if(value!.isEmpty) return "Please Enter Time";
                                        return null;
                                      },
                                      onSaved: (value){
                                        try{
                                          time=int.parse(value!);
                                        }catch (e){

                                        }
                                      },
                                      keyboardType: TextInputType.number,

                                      textInputAction: (widgetTypeIndex==1 || widgetTypeIndex==3)?TextInputAction.done:TextInputAction.next,
                                      decoration:Styles.getDecorationWithLable("Time (Minutes)")
                                  ),
                                  Constants.kSmallBox,
                                ],
                              ):SizedBox(),
                            ],
                          ),
                        ),

                        Consumer<HabitsProvider>(
                          builder: (context,provider,child) {
                            return isDeleteEditLoading?Center(
                              child: CustomCircularIndicator(),
                            ):SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: ColorConstant.kBlueColor),
                                  onPressed: (){
                                    if(formKey.currentState!.validate()){
                                      formKey.currentState!.save();
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
                                              widgetType: RandomTaskModal.widgetTypeList[widgetTypeIndex],
                                              description: descriptionValue.value,
                                              progress: progress,
                                              time: time,
                                              sets: sets,
                                              rest: rest
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
                                    }

                                  },
                                  child: const Text('Save')
                              ),
                            );
                          }
                        ),
                        Constants.kVerySmallBox,
                        Text(
                          "Chain",
                          style: Styles.opacityHeadingStyle,
                        ),
                        Constants.kVerySmallBox,
                        OpenChainNavigationWidget(
                          habitId: habit.id,habitName: habit.name,
                        ),
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
                            ):SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.red),
                                  onPressed: (){
                                    showPasswordModal(
                                        context: context,
                                        id: habit.id.toString(),
                                      provider: habitProvider
                                    );
                                  },
                                  child: const Text('Delete')
                              ),
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
