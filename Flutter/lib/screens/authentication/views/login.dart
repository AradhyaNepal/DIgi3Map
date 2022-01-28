import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/common/widgets/logo_widget.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/authentication/widgets/LoginFormWidget.dart';
import 'package:digi3map/screens/authentication/widgets/SocialWidget.dart';
import 'package:digi3map/testing_all_navigation.dart';
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
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: size.height,
            width: size.width,
            padding: Constants.kPagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Constants.kBigBox,
                LogoWidget(),
                Constants.kBigBox,
                LoginFormWidget(),
                Flexible(
                  child: Row(
                    children: [
                      Spacer(),
                      TextButton(
                          onPressed: (){
                            TestingAllNavigation.goToTestingPage(context);
                          },
                          child: Text(
                            'Forgot Password?',
                              style:GoogleFonts.roboto(
                                  color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500

                              )
                          )
                      ),

                    ],
                  ),
                ),

                Flexible(
                  child: Row(
                    children: [
                      Spacer(),
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
                                    TestingAllNavigation.goToTestingPage(context);
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: GoogleFonts.openSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold
                                    ),
                                  )
                              )
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                Flexible(child: SocialWidget())
              ],
            ),
          ),
        ),
      ),
    );
  }


}
