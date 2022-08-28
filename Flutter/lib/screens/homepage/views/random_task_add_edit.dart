import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/common/widgets/selection_collection.dart';
import 'package:digi3map/screens/domain_crud/widget/image_picker.dart';
import 'package:digi3map/screens/homepage/provides/random_provider.dart';
import 'package:digi3map/screens/homepage/provides/selection_notification.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class RandomTaskAddEdit extends StatefulWidget {
  final RandomTaskModal? modal;
  final RandomProvider provider;
  const RandomTaskAddEdit({
    required this.provider,
    this.modal,
    Key? key
  }) : super(key: key);

  @override
  State<RandomTaskAddEdit> createState() => _RandomTaskAddEditState();
}

class _RandomTaskAddEditState extends State<RandomTaskAddEdit> {
  bool forEdit=false;
  int widgetTypeIndex=0;

  final GlobalKey<FormState> formKey=GlobalKey();
  final ValueNotifier<String?> imageValue=ValueNotifier(null);
  final ValueNotifier<String> priorityValue=ValueNotifier("High");
  final ValueNotifier<bool> imageSelected=ValueNotifier(false);
  late final ValueNotifier<String> typeValue;
  String name="";
  String? description;
  int? time;
  int? sets;
  int? rest;
  bool isLoading=false;
  @override
  void initState() {
    super.initState();
    typeValue=ValueNotifier(RandomTaskModal.widgetTypeList[widgetTypeIndex]);
    forEdit=widget.modal!=null;
    if(forEdit){
      print(widget.modal!.id);
      imageValue.value=widget.modal!.imagePath;
      priorityValue.value=widget.modal!.priority;
      typeValue.value=widget.modal!.type;
      name=widget.modal!.name;
      description=widget.modal!.description;
      time=widget.modal!.time;
      sets=widget.modal!.sets;
      rest=widget.modal!.rest;
      widgetTypeIndex=RandomTaskModal.widgetTypeList.indexWhere((element) => element==typeValue.value);
      print("Index "+widgetTypeIndex.toString());
      if(widgetTypeIndex==-1) widgetTypeIndex=0;

    }
  }


  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          padding: Constants.kPagePaddingNoDown,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Random Task',
                    style: Styles.bigHeading,
                  ),
                  Constants.kSmallBox,
                  CustomImagePicker(
                      imageLocation: imageValue,
                    fromServer: imageValue.value!=null,
                    imageSelected: imageSelected,
                  ),
                  Constants.kVerySmallBox,
                  TextFormField(
                    initialValue: name,
                      validator: (value){
                        if(value!.isEmpty) return "Please Enter Domain Name";
                        return null;
                      },
                      onSaved: (value)=>name=value??"",
                      maxLength: 50,
                      textInputAction: TextInputAction.next,
                      decoration:Styles.getDecorationWithLable("Name")
                  ),
                  Constants.kVerySmallBox,
                  Text(
                    "Priority Value",
                    style: Styles.opacityHeadingStyle,
                  ),

                  Constants.kVerySmallBox,
                  SelectionCollection(
                    valuesList: RandomTaskModal.randomTaskPriorityList,
                    defaultValue: priorityValue.value,


                    value:priorityValue,
                  ),
                  Constants.kVerySmallBox,
                  Text(
                    "Widget Type",
                    style: Styles.opacityHeadingStyle,
                  ),

                  Constants.kVerySmallBox,
                  NotificationListener<SelectionNotification>(
                    onNotification: (value){
                      FocusScope.of(context).unfocus();
                      setState(() {
                        widgetTypeIndex=value.index;
                      });
                      return true;
                    },
                    child: SelectionCollection(
                      valuesList: RandomTaskModal.widgetTypeList,
                      defaultValue: typeValue.value,
                      value: typeValue,
                    ),
                  ),
                  Constants.kSmallBox,
                  Text(
                    "Widget Details",
                    style: Styles.opacityHeadingStyle,
                  ),
                  Constants.kVerySmallBox,

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


                  (widgetTypeIndex==0 || widgetTypeIndex==2)?Column(
                    children: [
                      TextFormField(
                        initialValue: description,
                        maxLength:1000 ,
                        maxLines: 3,
                        keyboardType:TextInputType.multiline,
                        onSaved: (value)=>description=value,
                        textInputAction: TextInputAction.next,
                        decoration:Styles.getDecorationWithLable("Description"),
                        validator: (value){
                          if(value!.isEmpty) return "Please Enter Domain Description";
                          return null;
                        },
                      ),

                      Constants.kVerySmallBox,
                    ],
                  ):SizedBox(),


                  isLoading?
                  Center(
                    child: CustomCircularIndicator(),
                  ):CustomBlueButton(
                      text: "Add",
                      onPressed: () async{
                        if(formKey.currentState!.validate()){

                          if(imageValue.value==null){
                            CustomSnackBar.showSnackBar(context, "Please Select Image");
                          }
                          else{
                            setState(() {
                              isLoading=true;
                            });
                            formKey.currentState!.save();
                            print(widgetTypeIndex);
                            await widget.provider.addUpdateRandomTask(

                                RandomTaskModal(
                                  id: forEdit?widget.modal!.id:null,
                                  name: name,
                                  imagePath: imageValue.value??"",
                                  priority: priorityValue.value,
                                  type:RandomTaskModal.widgetTypeList[widgetTypeIndex],
                                  time: time,
                                  sets: sets,
                                  rest: rest,
                                  description: description

                                ),
                              haveNewImage: imageSelected.value
                            ).then((value){
                              CustomSnackBar.showSnackBar(context, forEdit?"Successfully Edited":"Successfully Added");

                              Navigator.pop(context);
                            }).onError((error, stackTrace) {
                              print(stackTrace);
                              CustomSnackBar.showSnackBar(context, error.toString());
                              setState(() {
                                isLoading=false;
                              });
                            });


                          }


                        }
                      }
                  ),
                  Constants.kMediumBox,

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

