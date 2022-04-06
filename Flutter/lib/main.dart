
import 'package:digi3map/screens/authentication/provides/auth.dart';
import 'package:digi3map/screens/homepage/views/splash_page.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Digi3Map",
      theme: ThemeData.light().copyWith(
        colorScheme: const ColorScheme.light().copyWith(primary:ColorConstant.kBlueColor,secondary: ColorConstant.kBlueColor),

      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context)=>Auth()
          ),
        ],
        child: SplashPage(),
      ),
    );
  }
}
