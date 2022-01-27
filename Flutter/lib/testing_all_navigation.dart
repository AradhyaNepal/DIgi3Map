import 'package:digi3map/screens/homepage/views/splash_page.dart';
import 'package:digi3map/screens/onBoarding/view/onBoarding.dart';
import 'package:flutter/material.dart';

class TestingAllNavigation extends StatelessWidget {
  const TestingAllNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Testing All Navigation"),),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SplashPage()));
            },
            child: const Text("Splash Page"),
          ),
          ElevatedButton(
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const OnBoarding()));
            },
            child: const Text("On Boarding"),
          ),
        ],
      ),
    );
  }
}
