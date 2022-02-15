import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/screens/authentication/widgets/password_textfield.dart';
import 'package:digi3map/testing_all_navigation.dart';
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
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Constants.kBigBox,
                    Constants.kBigBox,
                    const Text("Change Password",style: Styles.bigHeading,),
                    Constants.kSmallBox,
                    PasswordForm(
                        nextNode:_passwordNode,
                        valueProvider: ValueNotifier(null),
                        heading: "Old Password"
                    ),
                    Constants.kSmallBox,
                    PasswordForm(
                        focusNode: _passwordNode,
                        nextNode: _confirmationNode,
                        valueProvider: ValueNotifier(null),
                        heading: "New Password"
                    ),
                    Constants.kSmallBox,
                    PasswordForm(
                        focusNode: _confirmationNode,
                        valueProvider: ValueNotifier(null),
                        heading: "Confirm Password"
                    ),
                    Constants.kMediumBox,
                    _pageLoading?const CustomCircularIndicator():CustomBlueButton(
                        text: "Change Password",
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            _formKey.currentState!.save();
                            FocusScope.of(context).unfocus();
                            setState(() {
                              _pageLoading=true;
                            });
                            Future.delayed(const Duration(seconds: 1),(){
                              TestingAllNavigation.goToTestingPage(context);
                            });
                          }
                        }
                    ),
                    Constants.kSmallBox,
                    Flexible(
                      child: Row(
                        children: [
                          const Spacer(),
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
