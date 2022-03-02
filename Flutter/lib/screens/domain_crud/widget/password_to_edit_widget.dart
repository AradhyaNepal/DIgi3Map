import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/screens/authentication/views/forgot_password_pin.dart';
import 'package:digi3map/screens/authentication/widgets/password_textfield.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class PasswordToEditWidget extends StatefulWidget {
  final String purpose;
  const PasswordToEditWidget({
    required this.purpose,
    Key? key
  }) : super(key: key);

  @override
  State<PasswordToEditWidget> createState() => _PasswordToEditWidgetState();
}

class _PasswordToEditWidgetState extends State<PasswordToEditWidget> {
  final GlobalKey<FormState> _formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height*0.6,
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        insetPadding:const EdgeInsets.all(5),
        content: Card(
          elevation: 10,
          color: ColorConstant.kGreyCardColor,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Enter Password",
                    style: Styles.bigHeading,
                  ),
                  Constants.kVerySmallBox,
                  Text(
                    widget.purpose,
                    style: Styles.smallHeading,
                  ),
                  Constants.kVerySmallBox,
                  Form(
                    key: _formKey,
                    child: PasswordForm(

                        valueProvider: ValueNotifier(null),
                        heading: "Password"
                    ),
                  ),
                  Constants.kVerySmallBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: (){

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>  ForgotPasswordPin(

                                )));
                          },
                          child: Text(
                            'Forgot Password',
                            style: Styles.forgotPasswordStyle,
                          )
                      )
                    ],
                  ),
                  Constants.kVerySmallBox,
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                    child: CustomBlueButton(
                        text: "Done",
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            Navigator.pop(context);

                          }
                        }
                    ),
                  ),
                  Constants.kVerySmallBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: Styles.blueHighlight,
                        ),
                      )
                    ],
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
