import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/CustomCircularIndicator.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/testing_all_navigation.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isLoading=false;
  bool _showPassword=false;
  bool _showConfirmation=false;
  final GlobalKey<FormState> _formKey=GlobalKey();
  String? _emailValue,_passwordValue,_confirmationValue;
  final FocusNode _passwordFocus=FocusNode();
  final FocusNode _confirmationFocus=FocusNode();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                      child: Icon(Icons.person_outline_rounded,color: ColorConstant.iconColor,)
                  ),
                  Constants.kSmallBox,
                  Expanded(
                    flex: 9,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value)=>_emailValue=value,
                      onFieldSubmitted: (value){
                        FocusScope.of(context).requestFocus(_passwordFocus);
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please Enter Email";
                        }
                        return null;
                      },
                      decoration: Styles.getSimpleInputDecoration("Email Address")
                    ),
                  ),
                ],
              ),
            ),
          ),
          Constants.kSmallBox,
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Icon(Icons.lock_outline_rounded,color: ColorConstant.iconColor,)
                  ),
                  Constants.kSmallBox,
                  Expanded(
                    flex: 8,
                    child: TextFormField(
                      onFieldSubmitted: (value){
                        FocusScope.of(context).requestFocus(_confirmationFocus);
                      },
                      focusNode: _passwordFocus,
                      textInputAction: TextInputAction.next,
                      onSaved: (value)=>_passwordValue=value,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please Enter Password";
                        }
                        return null;
                      },
                      obscureText:! _showPassword,
                      decoration: Styles.getSimpleInputDecoration("Password")
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: (){
                          setState(() {
                            _showPassword=!_showPassword;
                          });
                        },
                        icon: Icon(
                          _showPassword?Icons.visibility_off_outlined:Icons.visibility_outlined,
                          color: ColorConstant.iconColor,
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),
          Constants.kSmallBox,
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Icon(Icons.lock_outline_rounded,color: ColorConstant.iconColor,)
                  ),
                  Constants.kSmallBox,
                  Expanded(
                    flex: 8,
                    child: TextFormField(
                      focusNode: _confirmationFocus,
                      obscureText:! _showConfirmation,
                      onSaved: (value)=>_confirmationValue=value,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please Enter Confirmation";
                        }
                        return null;
                      },
                      decoration: Styles.getSimpleInputDecoration("Confirm Password"),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: (){
                          setState(() {
                            _showConfirmation=!_showConfirmation;
                          });
                        },
                        icon: Icon(
                          _showConfirmation?Icons.visibility_off_outlined:Icons.visibility_outlined,
                          color: ColorConstant.iconColor,
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),
          Constants.kSmallBox,
          _isLoading?CustomCircularIndicator():CustomBlueButton(
              text: "Sign Up",
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
          Constants.kSmallBox
        ],
      ),
    );
  }
}
