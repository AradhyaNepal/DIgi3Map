import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/common/widgets/selection_collection.dart';
import 'package:digi3map/screens/domain_crud/provider/domain_provider.dart';
import 'package:digi3map/screens/domain_crud/view/add_domain.dart';
import 'package:digi3map/screens/domain_crud/widget/image_picker.dart';
import 'package:digi3map/screens/habits/provider/habits_provider.dart';
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
  final GlobalKey<FormState> _formKey=GlobalKey();

  ValueNotifier<String> domainValue=ValueNotifier("Fitness");

  ValueNotifier<String> widgetValue=ValueNotifier("Todo");

  String name="",description="";

  ValueNotifier<String?> imageValue=ValueNotifier(null);

  bool isLoading=false;
  @override
  void initState() {
    if(widget.defaultDomain!=null) domainValue.value=widget.defaultDomain??"Fitness";
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
                          Text('Domain',style: Styles.forgotPasswordStyle,),
                          Constants.kVerySmallBox,

                          Consumer<HabitsProvider>(
                            builder: (context,provider,child) {
                              if(provider.isDomainLoading) {
                                return Center(
                                  child: CustomCircularIndicator(),
                                );
                              }
                              if(provider.domainList.length==0 && provider.addingAllowed==false){
                                return Text("Cannot Add, All Domains Are Occupied With 2 Habits");
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
                          Text('Domain',style: Styles.forgotPasswordStyle,),
                          Constants.kVerySmallBox,
                          SelectionCollection(

                              value: widgetValue,
                              valuesList: Habit.widgetList
                          ),
                          Constants.kSmallBox,

                          Consumer<HabitsProvider>(
                            builder: (context,provider,child) {
                              if(provider.isDomainLoading || isLoading){
                                return Center(
                                  child: CustomCircularIndicator(),
                                );
                              }
                              if(provider.domainList.length==0 && provider.addingAllowed==false){
                                return Text("Cannot Add, All Domains Are Occupied With 2 Habits");
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
                                              widgetType: widgetValue.value,
                                              description: description,
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
