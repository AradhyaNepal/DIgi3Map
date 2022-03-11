import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/screens/authentication/provides/auth.dart';
import 'package:digi3map/screens/authentication/views/login.dart';
import 'package:digi3map/screens/authentication/widgets/custom_textfield.dart';
import 'package:digi3map/screens/authentication/widgets/password_textfield.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class ChangePasswordAfterPin extends StatefulWidget {
  const ChangePasswordAfterPin({Key? key}) : super(key: key);

  @override
  _ChangePasswordAfterPinState createState() => _ChangePasswordAfterPinState();
}

class _ChangePasswordAfterPinState extends State<ChangePasswordAfterPin> {
  final ValueNotifier<String?> _tokenValue=ValueNotifier(null);
  final ValueNotifier<String?> _passwordValue=ValueNotifier(null);
  final ValueNotifier<String?> _confirmPasswordValue=ValueNotifier(null);
  final FocusNode _passwordFocusNode=FocusNode();
  final FocusNode _confirmationFocusNode=FocusNode();
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
                  const Text(
                      "Change Password",
                    style: Styles.bigHeading,
                  ),
                  Constants.kBigBox,
                  CustomTextfield(
                    icon:Icons.attach_email,
                    nextNode: _passwordFocusNode,
                      heading: "Token From Email",
                      valueNotifier: _tokenValue
                  ),
                  Constants.kSmallBox,
                  PasswordForm(
                    focusNode: _passwordFocusNode,
                      nextNode: _confirmationFocusNode,
                      valueProvider: _passwordValue,
                      heading: "New Password"
                  ),
                  Constants.kSmallBox,
                  PasswordForm(
                      focusNode: _confirmationFocusNode,
                      valueProvider: _confirmPasswordValue,
                      heading: "Confirm Password"
                  ),

                  Constants.kBigBox,
                  _isLoading?const CustomCircularIndicator():CustomBlueButton(
                      text: "Change Password",
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          _formKey.currentState!.save();
                          FocusScope.of(context).unfocus();
                          if(_passwordValue.value!=_confirmPasswordValue.value){
                            CustomSnackBar.showSnackBar(context, "Password And Confirm Password Didn't Match");
                            return;

                          }
                          setState(() {
                            _isLoading=true;
                          });
                          changePassword();

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

  void changePassword(){
    Auth().confirmResetPassword(_tokenValue.value??"",_passwordValue.value??"").then((value) {
      CustomSnackBar.showSnackBar(context, "Password Successfully Changed");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => LoginPage()));
    }).onError((error, stackTrace) {

      CustomSnackBar.showSnackBar(context, error.toString());
      setState(() {
        _isLoading=false;
      });
    });
  }
}
