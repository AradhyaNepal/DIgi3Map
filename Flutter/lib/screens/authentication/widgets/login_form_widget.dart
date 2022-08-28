import 'package:digi3map/common/classes/HttpException.dart';
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/screens/authentication/provides/auth.dart';
import 'package:digi3map/screens/authentication/widgets/custom_textfield.dart';
import 'package:digi3map/screens/authentication/widgets/password_textfield.dart';
import 'package:digi3map/screens/homepage/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({Key? key}) : super(key: key);


  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final ValueNotifier<String?> _emailValue=ValueNotifier(null);
  final ValueNotifier<String?> _passwordValue=ValueNotifier(null);

  bool _isLoading=false;
  final FocusNode _passwordNode=FocusNode();

  final GlobalKey<FormState> _formKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextfield(
              heading: "Username",
                valueNotifier: _emailValue,
                nextNode: _passwordNode
            ),
            Constants.kSmallBox,
            PasswordForm(
              focusNode: _passwordNode,
                valueProvider: _passwordValue,
                heading: "Password"
            ),
            Constants.kSmallBox,
            _isLoading?const CustomCircularIndicator():CustomBlueButton(
                text: "Login",
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                    _formKey.currentState!.save();
                    FocusScope.of(context).unfocus();
                    setState(() {
                      _isLoading=true;
                    });
                    login(_emailValue.value??"", _passwordValue.value??"");


                  }
                }
            ),
          ],
        )
    );
  }

  void login(String email,String password) async{
    await Auth().login(email, password).then((value) {
      CustomSnackBar.showSnackBar(context, "Successfully Logged In");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const HomePage()));

    }).onError((error, stackTrace) {
      CustomSnackBar.showSnackBar(context, error.toString());
      print(stackTrace);
      setState(() {
        _isLoading=false;
      });
    });




  }
}
