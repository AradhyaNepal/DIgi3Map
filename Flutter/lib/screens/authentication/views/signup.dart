import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/logo_widget.dart';
import 'package:digi3map/screens/authentication/widgets/signup_form.dart';
import 'package:digi3map/screens/authentication/widgets/social_widget.dart';
import 'package:digi3map/testing_all_navigation.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                const SignUpForm(),
                Row(
                  children: [
                    const Spacer(),
                    Text("Already Have Account?",
                      style:GoogleFonts.openSans(
                        fontSize: 13
                      ),
                    ),
                    TextButton(
                        onPressed: (){
                          TestingAllNavigation.goToTestingPage(context);
                        },
                        child: Text(
                            "Login",
                          style: GoogleFonts.openSans(
                              fontSize: 13,
                              color: ColorConstant.kBlueColor,
                              fontWeight: FontWeight.bold
                          ),
                        )
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
