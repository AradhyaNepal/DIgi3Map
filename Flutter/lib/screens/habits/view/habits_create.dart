import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/common/widgets/selection_collection.dart';
import 'package:digi3map/screens/domain_crud/widget/image_picker.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class AddHabits extends StatelessWidget {

  AddHabits({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey=GlobalKey();
  final ValueNotifier<String?> _imageLocation=ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
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
                        CustomImagePicker(imageLocation: _imageLocation,),
                        Constants.kSmallBox,
                        TextFormField(
                            validator: (value){
                              if(value!.isEmpty) return "Please Enter Habits Name";
                              return null;
                            },
                            maxLength: 50,
                            decoration:Styles.getDecorationWithLable("Name")
                        ),
                        Constants.kVerySmallBox,
                        TextFormField(
                          maxLength:1000 ,
                          maxLines: 3,
                          keyboardType:TextInputType.multiline,
                          decoration:Styles.getDecorationWithLable("Description"),
                          validator: (value){
                            if(value!.isEmpty) return "Please Enter Habits Description";
                            return null;
                          },
                        ),
                        Constants.kSmallBox,
                        Text('Domain',style: Styles.forgotPasswordStyle,),
                        Constants.kVerySmallBox,
                        Wrap(
                          children: [
                            SelectionCollection(
                                valuesList: [
                                  'High',
                                  'Low',
                                  'Medium'
                                ]
                            ),
                            ElevatedButton(
                                onPressed: (){},
                                child: Text(
                                  "Add",
                                  style: Styles.mediumHeading,
                                )
                            )
                          ],
                        ),
                        Constants.kSmallBox,
                        Text('Domain',style: Styles.forgotPasswordStyle,),
                        Constants.kVerySmallBox,
                        SelectionCollection(
                            valuesList: [
                              'Sets and Reps',
                              'Time',
                              'Todo'
                            ]
                        ),
                        Constants.kSmallBox,
                        CustomBlueButton(
                            text: 'Add',
                            onPressed: (){
                              if(_formKey.currentState!.validate()){
                                if(_imageLocation.value==null){
                                  CustomSnackBar.showSnackBar(context, "Please Pick Habit Image");
                                  return;
                                }
                                Navigator.pop(context);
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
          ),
        )
    );
  }
}
