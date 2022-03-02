import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/screens/authentication/views/verification_sign_up.dart';
import 'package:digi3map/screens/authentication/widgets/custom_textfield.dart';
import 'package:digi3map/screens/authentication/widgets/password_textfield.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);


  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isLoading=false;
  final GlobalKey<FormState> _formKey=GlobalKey();
  final FocusNode _passwordFocus=FocusNode();
  final FocusNode _confirmationFocus=FocusNode();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextfield(
              valueNotifier: ValueNotifier(null),
              nextNode: _passwordFocus
          ),
          Constants.kSmallBox,
          PasswordForm(
              valueProvider: ValueNotifier(null),
              heading: "Password",
            focusNode: _passwordFocus,
            nextNode: _confirmationFocus,
          ),
          Constants.kSmallBox,
          PasswordForm(
              valueProvider: ValueNotifier(null),
              heading: "Confirmation Password",
            focusNode: _confirmationFocus,
          ),
          Constants.kSmallBox,
          _isLoading?const CustomCircularIndicator():CustomBlueButton(
              text: "Sign Up",
              onPressed: (){
                if(_formKey.currentState!.validate()){
                  _formKey.currentState!.save();
                  FocusScope.of(context).unfocus();
                  setState(() {
                    _isLoading=true;
                  });
                  Future.delayed(const Duration(seconds: 2),(){

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>  VerificationSignUp()));
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
