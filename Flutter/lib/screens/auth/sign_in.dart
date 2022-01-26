import 'package:digi3map/screens/homepage/views/splash_page.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Center(
          child: ElevatedButton(
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SplashPage()));
            },
            child: Text("Open Again"),
          ),
        )
    );
  }
}
