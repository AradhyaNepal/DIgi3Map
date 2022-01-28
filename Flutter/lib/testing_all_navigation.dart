import 'package:digi3map/screens/authentication/views/login.dart';
import 'package:digi3map/screens/authentication/views/signup.dart';
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
