import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/screens/authentication/provides/auth.dart';
import 'package:digi3map/screens/authentication/views/verification_sign_up.dart';
import 'package:digi3map/screens/authentication/widgets/custom_textfield.dart';
import 'package:digi3map/screens/authentication/widgets/password_textfield.dart';
import 'package:digi3map/screens/homepage/views/home_page.dart';
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
  final ValueNotifier<String?> _emailValue=ValueNotifier(null);
  final ValueNotifier<String?> _usernameValue=ValueNotifier(null);
  final ValueNotifier<String?> _passwordValue=ValueNotifier(null);
  final ValueNotifier<String?> _confirmPasswordValue=ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextfield(
            heading: "Email",
              valueNotifier: _emailValue,
              nextNode: _passwordFocus
          ),
          Constants.kSmallBox,
          CustomTextfield(
              heading: "Username",
              valueNotifier: _usernameValue,
              nextNode: _passwordFocus
          ),
          Constants.kSmallBox,
          PasswordForm(
              valueProvider: _passwordValue,
              heading: "Password",
            focusNode: _passwordFocus,
            nextNode: _confirmationFocus,
          ),
          Constants.kSmallBox,
          PasswordForm(
              valueProvider: _confirmPasswordValue,
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
                  if(_passwordValue.value!=_confirmPasswordValue.value){
                    CustomSnackBar.showSnackBar(context, "Password And Confirm Password Didn't match");
                    setState(() {
                      _isLoading=false;
                    });
                    return;
                  }
                  signUp(email:_emailValue.value??"", password:_passwordValue.value??"", username:_usernameValue.value??"");
                }

              }
          ),
          Constants.kSmallBox
        ],
      ),
    );
  }

  void signUp({
    required String email,required String password, required String username
}) async{
    await Auth().signUp(email:email, username:username, password: password).then((value) {
      CustomSnackBar.showSnackBar(context, "Successfully Signed Up");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const HomePage()));
    }).onError((error, stackTrace) {
      setState(() {
        CustomSnackBar.showSnackBar(context, error.toString());
        print(stackTrace);
        _isLoading=false;
      });
    });

  }
}
