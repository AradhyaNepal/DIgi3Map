import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/CustomCircularIndicator.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/testing_all_navigation.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class ChangePasswordWithOld extends StatefulWidget {
  @override
  State<ChangePasswordWithOld> createState() => _ChangePasswordWithOldState();
}

class _ChangePasswordWithOldState extends State<ChangePasswordWithOld> {
  bool _oldPasswordVisible=false,_confirmPasswordVisible=false,_newPasswordVisible=false;
  String? _oldPasswordValue,_newPasswordValue,_confirmationValue;
  final FocusNode _passwordNode=FocusNode();
  final FocusNode _confirmationNode=FocusNode();
  bool _pageLoading=false;

  final GlobalKey<FormState> _formKey=GlobalKey();
  @override
  void dispose() {
    // TODO: implement dispose
    _passwordNode.dispose();
    _confirmationNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: Constants.kPagePaddingNoDown,
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Container(
                width: size.width,
                height: size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Constants.kBigBox,
                    Constants.kBigBox,
                    Text("Change Password",style: Styles.bigHeading,),

                    Constants.kSmallBox,
                    Card(
                      elevation: 3,
                      margin: EdgeInsets.all(0),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child:Icon(Icons.lock_outline_rounded,color: ColorConstant.kIconColor,)
                            ),
                            Constants.kSmallBox,
                            Expanded(
                              flex:8,
                              child: TextFormField(
                                onFieldSubmitted: (value){
                                  FocusScope.of(context).requestFocus(_passwordNode);
                                },
                                textInputAction: TextInputAction.next,
                                obscureText: !_oldPasswordVisible,
                                validator: (value){
                                  if(value!.isEmpty) return "Please Enter Old Password";
                                  return null;
                                },
                                onSaved: (value)=>_oldPasswordValue=value,
                                decoration: Styles.getSimpleInputDecoration("Old password"),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child:IconButton(
                                  onPressed: (){
                                    setState(() {
                                      _oldPasswordVisible=!_oldPasswordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    _oldPasswordVisible?Icons.visibility_off_outlined:Icons.visibility_outlined,
                                    color: ColorConstant.kIconColor,
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                    Constants.kSmallBox,
                    Card(
                      elevation: 3,

                      margin: EdgeInsets.all(0),
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
                              flex:8,
                              child: TextFormField(
                                focusNode: _passwordNode,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (value){
                                  FocusScope.of(context).requestFocus(_confirmationNode);
                                },
                                onSaved: (value)=>_newPasswordValue=value,
                                validator: (value){
                                  if(value!.isEmpty) return "Please Enter New Password";
                                  return null;
                                },
                                obscureText: !_newPasswordVisible,
                                decoration: Styles.getSimpleInputDecoration("New Password"),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      _newPasswordVisible=!_newPasswordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    _newPasswordVisible?Icons.visibility_off_outlined:Icons.visibility_outlined,
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
                      elevation: 3,
                      margin: EdgeInsets.all(0),
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
                              flex:8,
                              child: TextFormField(
                                focusNode: _confirmationNode,
                                textInputAction: TextInputAction.done,
                                obscureText: !_confirmPasswordVisible,
                                onSaved: (value)=>_confirmationValue=value,
                                validator: (value){
                                  if(value!.isEmpty) return "Please Enter Confirmation Password";
                                  return null;
                                },
                                decoration: Styles.getSimpleInputDecoration("Confirmation Password"),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                                child: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      _confirmPasswordVisible=!_confirmPasswordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    _confirmPasswordVisible?Icons.visibility_off_outlined:Icons.visibility_outlined,
                                    color: ColorConstant.kIconColor,
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                    Constants.kMediumBox,
                    _pageLoading?CustomCircularIndicator():CustomBlueButton(
                        text: "Change Password",
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            _formKey.currentState!.save();
                            FocusScope.of(context).unfocus();
                            setState(() {
                              _pageLoading=true;
                            });
                            Future.delayed(Duration(seconds: 1),(){
                              TestingAllNavigation.goToTestingPage(context);
                            });
                          }
                        }
                    ),
                    Constants.kSmallBox,
                    Flexible(
                      child: Row(
                        children: [
                          Spacer(),
                          TextButton(
                            onPressed: (){
                              TestingAllNavigation.goToTestingPage(context);
                            },
                            child: Text(
                                "Forgot Password",
                              style: Styles.forgotPasswordStyle ,
                            ),
                          )
                        ],
                      ),
                    ),

                    Constants.kBigBox,
                    Constants.kBigBox,

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
