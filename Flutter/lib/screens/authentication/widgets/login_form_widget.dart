import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/screens/authentication/widgets/custom_textfield.dart';
import 'package:digi3map/screens/authentication/widgets/password_textfield.dart';
import 'package:digi3map/testing_all_navigation.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({Key? key}) : super(key: key);


  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
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
                valueNotifier: ValueNotifier(null),
                nextNode: _passwordNode
            ),
            Constants.kSmallBox,
            PasswordForm(
              focusNode: _passwordNode,
                valueProvider: ValueNotifier(null),
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
                    Future.delayed(const Duration(seconds: 2),(){
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
