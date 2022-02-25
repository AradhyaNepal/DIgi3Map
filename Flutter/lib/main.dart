import 'package:digi3map/testing_all_navigation.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Digi3Map",
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.light().copyWith(primary:ColorConstant.kBlueColor,secondary: ColorConstant.kBlueColor),

      ),
      home: TestingAllNavigation(),
    );
  }
}
