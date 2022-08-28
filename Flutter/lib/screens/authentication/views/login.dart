import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/logo_widget.dart';
import 'package:digi3map/screens/authentication/views/forgot_password_email.dart';
import 'package:digi3map/screens/authentication/views/forgot_password_pin.dart';
import 'package:digi3map/screens/authentication/views/signup.dart';
import 'package:digi3map/screens/authentication/widgets/login_form_widget.dart';
import 'package:digi3map/screens/authentication/widgets/social_widget.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          padding: Constants.kPagePaddingNoDown,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Constants.kBigBox,
                const LogoWidget(),
                Constants.kBigBox,
                const LoginFormWidget(),
                Constants.kSmallBox,
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                        onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ForgotPasswordEmail()));
                        },
                        child: Text(
                          'Forgot Password?',
                            style:Styles.forgotPasswordStyle
                        )
                    ),

                  ],
                ),

                Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 8,
                      child: FittedBox(
                        child: Row(
                          children: [
                            Text(
                              "Don't Have An Account?",
                              style: GoogleFonts.openSans(
                                  fontSize: 13
                              ),
                            ),
                            TextButton(
                                onPressed: (){
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) => const SignUpPage()));
                                },
                                child: Text(
                                  'Sign Up',
                                  style: GoogleFonts.openSans(
                                      fontSize: 13,
                                      color: ColorConstant.kBlueColor,
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SocialWidget(),

                Constants.kMediumBox
              ],
            ),
          ),
        ),
      ),
    );
  }


}
