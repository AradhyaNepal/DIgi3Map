import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/screens/authentication/provides/auth.dart';
import 'package:digi3map/screens/authentication/views/forgot_password_email.dart';
import 'package:digi3map/screens/authentication/views/forgot_password_pin.dart';
import 'package:digi3map/screens/authentication/widgets/password_textfield.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class ChangePasswordWithOld extends StatefulWidget {
  const ChangePasswordWithOld({Key? key}) : super(key: key);

  @override
  State<ChangePasswordWithOld> createState() => _ChangePasswordWithOldState();
}

class _ChangePasswordWithOldState extends State<ChangePasswordWithOld> {
  final FocusNode _passwordNode=FocusNode();
  final FocusNode _confirmationNode=FocusNode();
  bool _pageLoading=false;
  final ValueNotifier<String?> _oldPasswordValue=ValueNotifier(null);
  final ValueNotifier<String?> _passwordValue=ValueNotifier(null);
  final ValueNotifier<String?> _confirmPasswordValue=ValueNotifier(null);

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Constants.kBigBox,
                  Constants.kBigBox,
                  const Text("Change Password",style: Styles.bigHeading,),
                  Constants.kSmallBox,
                  PasswordForm(
                      nextNode:_passwordNode,
                      valueProvider: _oldPasswordValue,
                      heading: "Old Password"
                  ),
                  Constants.kSmallBox,
                  PasswordForm(
                      focusNode: _passwordNode,
                      nextNode: _confirmationNode,
                      valueProvider: _passwordValue,
                      heading: "New Password"
                  ),
                  Constants.kSmallBox,
                  PasswordForm(
                      focusNode: _confirmationNode,
                      valueProvider: _confirmPasswordValue,
                      heading: "Confirm Password"
                  ),
                  Constants.kMediumBox,
                  _pageLoading?const CustomCircularIndicator():CustomBlueButton(
                      text: "Change Password",
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          _formKey.currentState!.save();
                          FocusScope.of(context).unfocus();
                          if(_passwordValue.value!=_confirmPasswordValue.value){
                            CustomSnackBar.showSnackBar(context, "Password And Confirm Password Didn't match");
                            return;
                          }
                          setState(() {
                            _pageLoading=true;
                          });
                          changePassword();
                        }
                      }
                  ),
                  Constants.kSmallBox,
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: (){
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => ForgotPasswordEmail()));
                        },
                        child: Text(
                            "Forgot Password",
                          style: Styles.forgotPasswordStyle ,
                        ),
                      )
                    ],
                  ),

                  Constants.kBigBox,
                  Constants.kBigBox,

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void changePassword(){
    Auth().changePassword(_oldPasswordValue.value??"", _passwordValue.value??"").then((value) {
      CustomSnackBar.showSnackBar(context, "Password Successfully Changed");
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      setState(() {
        CustomSnackBar.showSnackBar(context, error.toString());
        _pageLoading=false;
      });
    });
  }
}
