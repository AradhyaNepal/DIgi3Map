import 'dart:developer';

import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/common/widgets/selection_collection.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/domain_crud/provider/domain_provider.dart';
import 'package:digi3map/screens/domain_crud/widget/image_picker.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddDomain extends StatefulWidget {

  final DomainProvider provider;
  AddDomain({required this.provider,Key? key}) : super(key: key);

  @override
  State<AddDomain> createState() => _AddDomainState();
}

class _AddDomainState extends State<AddDomain> {
  final GlobalKey<FormState> _formKey=GlobalKey();

  final ValueNotifier<String?> _imageLocation=ValueNotifier(null);

  String? name, description;
  bool isLoading=false;
  final ValueNotifier<String> priority=ValueNotifier("Low");

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
                        const Text('Add Domain',style: Styles.bigHeading,),
                        Constants.kMediumBox,
                        CustomImagePicker(imageLocation: _imageLocation,),
                        Constants.kSmallBox,
                        TextFormField(
                          validator: (value){
                            if(value!.isEmpty) return "Please Enter Domain Name";
                            return null;
                          },
                            onSaved: (value)=>name=value,
                          maxLength: 50,
                          decoration:Styles.getDecorationWithLable("Name")
                        ),
                        Constants.kVerySmallBox,
                        TextFormField(
                          maxLength:1000 ,
                            maxLines: 3,
                            onSaved: (value)=>description=value,
                            keyboardType:TextInputType.multiline,
                            decoration:Styles.getDecorationWithLable("Description"),
                          validator: (value){
                            if(value!.isEmpty) return "Please Enter Domain Description";
                            return null;
                          },
                        ),
                        Constants.kSmallBox,
                        Text('Priority Value',style: Styles.forgotPasswordStyle,),
                        Constants.kVerySmallBox,
                        SelectionCollection(
                            valuesList: ['High','Low','Medium'],
                          value: priority,
                        ),
                        Constants.kSmallBox,
                        isLoading?CustomCircularIndicator():CustomBlueButton(
                            text: 'Add',
                            onPressed: () async{
                              if(_formKey.currentState!.validate()){
                                _formKey.currentState!.save();
                                if(_imageLocation.value==null){
                                  CustomSnackBar.showSnackBar(context, "Please Pick Domain Image");
                                  return;
                                }
                                setState(() {
                                  isLoading=true;
                                });
                                final sharedPref=await SharedPreferences.getInstance();
                                await widget.provider.addEditDomain(
                                  Domain(
                                      imagePath: _imageLocation.value??"",
                                      userId: sharedPref.getInt(Service.userId)??0,
                                      domainName:name??"",
                                      description: description??"",
                                      priority: priority.value,
                                  )
                                ).then((value) {
                                  CustomSnackBar.showSnackBar(context, "Domain Added");
                                  setState(() {
                                    isLoading=false;
                                  });
                                  Navigator.pop(context);
                                })
                                .onError((error, stackTrace) {
                                  setState(() {
                                    isLoading=false;
                                    CustomSnackBar.showSnackBar(context, error.toString());
                                  });
                                });

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
