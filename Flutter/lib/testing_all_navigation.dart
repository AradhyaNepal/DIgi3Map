import 'package:digi3map/screens/authentication/views/change_password_oldpass.dart';
import 'package:digi3map/screens/authentication/views/change_password_pin.dart';
import 'package:digi3map/screens/authentication/views/forgot_password_pin.dart';
import 'package:digi3map/screens/authentication/views/login.dart';
import 'package:digi3map/screens/authentication/views/signup.dart';
import 'package:digi3map/screens/authentication/views/verification_sign_up.dart';
import 'package:digi3map/screens/domain_list_graph/view/domain_list.dart';
import 'package:digi3map/screens/homepage/views/splash_page.dart';
import 'package:digi3map/screens/onBoarding/view/onBoarding.dart';
import 'package:flutter/material.dart';

class TestingAllNavigation extends StatelessWidget {
  const TestingAllNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; //Testing ko bela app close nai huna paudaina by clicking back button
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Testing All Navigation"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SplashPage()));
              },
              child: const Text("Splash Page"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const OnBoarding()));
              },
              child: const Text("On Boarding"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const Text("Login"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()));
              },
              child: const Text("SignUp"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  VerificationSignUp()));
              },
              child: const Text("Verification Sign Up (123456)"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  ForgotPasswordPin()));
              },
              child: const Text("Forgot Password (123456)"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  ChangePasswordWithOld()));
              },
              child: const Text("Change Password With Old"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  const ChangePasswordAfterPin()));
              },
              child: const Text("Change Password After Pin"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const DomainList()));
              },
              child: const Text("Domain"),
            ),
          ],
        ),
      ),
    );
  }

  static void goToTestingPage(BuildContext context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const TestingAllNavigation()));
  }
}
