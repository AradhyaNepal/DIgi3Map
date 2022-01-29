import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/CustomCircularIndicator.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/testing_all_navigation.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class LoginFormWidget extends StatefulWidget {

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  bool _passwordVisible=false;
  bool _isLoading=false;
  String? _emailValue;
  String? _passwordValue;
  final FocusNode _passwordNode=FocusNode();

  final GlobalKey<FormState> _formKey=GlobalKey();
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
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                        flex:1,
                        child: Icon(Icons.person_outline,color: ColorConstant.iconColor,)
                    ),
                    Constants.kSmallBox,
                    Expanded(
                      flex: 9,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        onFieldSubmitted: (value){
                          FocusScope.of(context).requestFocus(_passwordNode);
                        },
                        maxLength: 100,
                        validator: (value){
                          if(value!.isEmpty) return "Please Enter Email Address";
                          return null;
                        },
                        onSaved: (value)=>_emailValue=value,
                        decoration:Styles.getSimpleInputDecoration("Email Address")
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
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                        flex:1,
                        child: Icon(
                          Icons.lock_outline_rounded,color: ColorConstant.iconColor,
                        )
                    ),
                    Constants.kSmallBox,
                    Expanded(
                      flex: 8,
                      child: TextFormField(
                        focusNode: _passwordNode,
                        obscureText: !_passwordVisible,
                        maxLength: 100,
                        validator: (value){
                          if(value!.isEmpty) return "Please Enter Password";
                          return null;
                        },
                        onSaved: (value)=>_passwordValue=value,
                        decoration:Styles.getSimpleInputDecoration("Password")
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: (){
                          setState(() {
                            _passwordVisible=!_passwordVisible;
                          });
                        },
                        icon: Icon(
                          _passwordVisible?Icons.visibility_off_outlined:Icons.visibility_outlined,
                          color: ColorConstant.iconColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Constants.kSmallBox,
            _isLoading?CustomCircularIndicator():CustomBlueButton(
                text: "Login",
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
          ],
        )
    );
  }
}
