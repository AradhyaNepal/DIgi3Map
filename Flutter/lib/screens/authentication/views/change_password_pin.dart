import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/CustomCircularIndicator.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/testing_all_navigation.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class ChangePasswordAfterPin extends StatefulWidget {
  const ChangePasswordAfterPin({Key? key}) : super(key: key);

  @override
  _ChangePasswordAfterPinState createState() => _ChangePasswordAfterPinState();
}

class _ChangePasswordAfterPinState extends State<ChangePasswordAfterPin> {
  final FocusNode _confirmationFocusNode=FocusNode();
  String? _newPasswordValue,_confirmPasswordValue;
  bool _isPasswordVisible=false,_isConfirmationVisible=false;
  bool _isLoading=false;
  final GlobalKey<FormState> _formKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: size.height,
            width: size.width,
            padding: Constants.kPagePaddingNoDown,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Constants.kBigBox,
                  Constants.kBigBox,
                  Constants.kBigBox,
                  Text(
                      "Change Password",
                    style: Styles.bigHeading,
                  ),
                  Constants.kBigBox,

                  Card(
                    margin: const EdgeInsets.all(0),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Icon(Icons.lock_outline_rounded,color: ColorConstant.kIconColor,)
                          ),
                          Constants.kSmallBox,
                          Expanded(
                            flex: 8,
                            child: TextFormField(
                              obscureText: !_isPasswordVisible,
                              onSaved: (value)=>_newPasswordValue=value,
                              validator: (value){
                                if(value!.isEmpty) return "Please Enter New Password";
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (value){
                                FocusScope.of(context).requestFocus(_confirmationFocusNode);
                              },
                              decoration: Styles.getSimpleInputDecoration("New Password"),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                onPressed: (){
                                  setState(() {
                                    _isPasswordVisible=!_isPasswordVisible;
                                  });
                                },
                                icon: Icon(
                                  _isPasswordVisible?Icons.visibility_off_outlined:Icons.visibility_outlined,
                                  color: ColorConstant.kIconColor,
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                  Constants.kSmallBox,
                  Card(
                    margin: const EdgeInsets.all(0),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                              child: Icon(
                                Icons.lock_outline_rounded,
                                color: ColorConstant.kIconColor,
                              )
                          ),
                          Constants.kSmallBox,
                          Expanded(
                            flex: 8,
                              child: TextFormField(
                                obscureText: !_isConfirmationVisible,
                                focusNode: _confirmationFocusNode,
                                textInputAction: TextInputAction.done,
                                onSaved: (value)=>_confirmPasswordValue=value,
                                validator: (value){
                                  if(value!.isEmpty) return "Please Enter Confirmation";
                                  return null;
                                },
                                decoration: Styles.getSimpleInputDecoration("Confirmation Password"),
                              )
                          ),
                          Expanded(
                            flex: 1,
                              child: IconButton(
                                onPressed: (){
                                  setState(() {
                                    _isConfirmationVisible=!_isConfirmationVisible;
                                  });
                                },
                                icon: Icon(
                                  _isConfirmationVisible?Icons.visibility_off_outlined:Icons.visibility_outlined,
                                  color: ColorConstant.kIconColor,
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  ),

                  Constants.kBigBox,
                  _isLoading?CustomCircularIndicator():CustomBlueButton(
                      text: "Change Password",
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          _formKey.currentState!.save();
                          FocusScope.of(context).unfocus();
                          setState(() {
                            _isLoading=true;
                          });
                          Future.delayed(Duration(seconds: 2),(){
                            TestingAllNavigation.goToTestingPage(context);
                          });
                        }
                      }
                  ),
                  Constants.kBigBox,

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
