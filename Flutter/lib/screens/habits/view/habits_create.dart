import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/common/widgets/selection_collection.dart';
import 'package:digi3map/screens/domain_crud/provider/domain_provider.dart';
import 'package:digi3map/screens/domain_crud/view/add_domain.dart';
import 'package:digi3map/screens/domain_crud/widget/image_picker.dart';
import 'package:digi3map/screens/habits/provider/habits_provider.dart';
import 'package:digi3map/screens/homepage/provides/random_provider.dart';
import 'package:digi3map/screens/homepage/provides/selection_notification.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddHabits extends StatefulWidget {
  final String? defaultDomain;

  AddHabits({this.defaultDomain,Key? key}) : super(key: key);

  @override
  State<AddHabits> createState() => _AddHabitsState();
}

class _AddHabitsState extends State<AddHabits> {
  int widgetTypeIndex=0;
  int? time;
  int? rest;
  int? sets;
  final GlobalKey<FormState> _formKey=GlobalKey();

  ValueNotifier<String> domainValue=ValueNotifier("Fitness");

  late ValueNotifier<String> widgetValue;

  String name="",description="";

  ValueNotifier<String?> imageValue=ValueNotifier(null);

  bool isLoading=false;
  @override
  void initState() {
    if(widget.defaultDomain!=null) domainValue.value=widget.defaultDomain??"Fitness";
    widgetValue=ValueNotifier(RandomTaskModal.widgetTypeList[widgetTypeIndex]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context)=>HabitsProvider(),
      child: SafeArea(
          child: Scaffold(
            body: SizedBox(
              child: SizedBox(
                height: size.height,
                width: size.width,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: Constants.kPagePaddingNoDown,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text('Add Habits',style: Styles.bigHeading,),
                          Constants.kMediumBox,
                          CustomImagePicker(imageLocation: imageValue,),
                          Constants.kSmallBox,
                          TextFormField(
                              validator: (value){
                                if(value!.isEmpty) return "Please Enter Habits Name";
                                return null;
                              },
                              onSaved: (value)=>name=value??"",
                              maxLength: 50,
                              decoration:Styles.getDecorationWithLable("Name")
                          ),
                          Constants.kVerySmallBox,
                          TextFormField(
                            maxLength:1000 ,
                            maxLines: 3,
                            keyboardType:TextInputType.multiline,
                            decoration:Styles.getDecorationWithLable("Description"),
                            onSaved: (value)=>description=value??"",
                            validator: (value){
                              if(value!.isEmpty) return "Please Enter Habits Description";
                              return null;
                            },
                          ),
                          Constants.kSmallBox,
                          Text('Domain (Unmodifiable)',style: Styles.forgotPasswordStyle,),
                          Constants.kVerySmallBox,

                          Consumer<HabitsProvider>(
                            builder: (context,provider,child) {
                              if(provider.isDomainLoading) {
                                return Center(
                                  child: CustomCircularIndicator(),
                                );
                              }
                              if(provider.domainList.length==0 && provider.addingAllowed==false){
                                return Text(
                                    "Cannot Add, All Domains Are Occupied With 2 Habits",
                                  textAlign: TextAlign.center,
                                );
                              }
                              return Wrap(
                                children: [
                                  provider.domainList.isEmpty?SizedBox():SelectionCollection(
                                      value: domainValue,
                                      valuesList: provider.domainList
                                  ),
                                  provider.addingAllowed?ElevatedButton(
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
                          Constants.kSmallBox,
                          Text('Widget Type',style: Styles.forgotPasswordStyle,),
                          Constants.kVerySmallBox,
                          NotificationListener<SelectionNotification>(
                            onNotification: (value){
                              setState(() {
                                widgetTypeIndex=value.index;
                              });
                              return true;
                            },
                            child: SelectionCollection(

                                value: widgetValue,
                                valuesList: RandomTaskModal.widgetTypeList
                            ),
                          ),
                          Constants.kSmallBox,
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

                          Consumer<HabitsProvider>(
                            builder: (context,provider,child) {
                              if(provider.isDomainLoading || isLoading){
                                return Center(
                                  child: CustomCircularIndicator(),
                                );
                              }
                              if(provider.domainList.length==0 && provider.addingAllowed==false){
                                return Text("Cannot Add, All Domains Are Occupied With 2 Habits",textAlign: TextAlign.center,);
                              }

                              return CustomBlueButton(
                                  text: 'Add',
                                  onPressed: () async{
                                    if(_formKey.currentState!.validate()){
                                      _formKey.currentState!.save();
                                      if(imageValue.value==null){
                                        CustomSnackBar.showSnackBar(context, "Please Pick Habit Image");
                                        return;
                                      }
                                      setState(() {
                                        isLoading=true;
                                      });
                                      await provider.addUpdateHabit(
                                          Habit(
                                              name: name,
                                              domainName:domainValue.value,
                                              domainId: provider.idCalculator(domainValue.value),
                                              photoUrl: imageValue.value??"",
                                              widgetType: RandomTaskModal.widgetTypeList[widgetTypeIndex],
                                              description: description,
                                              sets: sets,
                                              rest: rest,
                                              time: time,
                                              progress: widgetValue.value
                                          )).then((value) {
                                            CustomSnackBar.showSnackBar(context, "Habit Successfully Added");
                                            Navigator.pop(context);
                                          }).onError((error, stackTrace){
                                            CustomSnackBar.showSnackBar(context, error.toString());
                                            setState(() {
                                              isLoading=false;
                                            });

                                      });
                                    }
                                  }
                              );
                            }
                          ),
                          Constants.kMediumBox,

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
      ),
    );
  }
}
