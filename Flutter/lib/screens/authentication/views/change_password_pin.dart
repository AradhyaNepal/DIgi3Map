import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/screens/authentication/widgets/password_textfield.dart';
import 'package:digi3map/testing_all_navigation.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class ChangePasswordAfterPin extends StatefulWidget {
  const ChangePasswordAfterPin({Key? key}) : super(key: key);

  @override
  _ChangePasswordAfterPinState createState() => _ChangePasswordAfterPinState();
}

class _ChangePasswordAfterPinState extends State<ChangePasswordAfterPin> {
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

                  PasswordForm(
                      nextNode: _confirmationFocusNode,
                      valueProvider: ValueNotifier(null),
                      heading: "New Password"
                  ),
                  Constants.kSmallBox,
                  PasswordForm(
                      focusNode: _confirmationFocusNode,
                      valueProvider: ValueNotifier(null),
                      heading: "Confirm Password"
                  ),

                  Constants.kBigBox,
                  _isLoading?const CustomCircularIndicator():CustomBlueButton(
                      text: "Change Password",
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
