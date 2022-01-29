import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles{
  Styles._();
  static const TextStyle logoTextStyle=TextStyle(
    fontFamily: AssetsLocation.twCenName,
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: ColorConstant.kBlueColor
  );

  static const TextStyle subLogoTextStyle=TextStyle(
    fontFamily: AssetsLocation.segoescName,
    fontSize: 20,
    color: ColorConstant.kBlueColor
  );

  static const TextStyle onBoardingHeading=TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
  static const TextStyle onBoardingValue=TextStyle(
    fontFamily: AssetsLocation.twCenName,
    height: 1.3

  );

  static const TextStyle bigHeading=TextStyle(
      fontFamily: AssetsLocation.twCenName,
      fontWeight: FontWeight.bold,
      fontSize: 25
  );

  static TextStyle forgotPasswordStyle=GoogleFonts.roboto(
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.w500

  );

  static InputDecoration getSimpleInputDecoration(String hintText){
    return InputDecoration(
        counterText: "",
        hintText: hintText,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none
    );

  }
  static InputDecoration pinDecoration=InputDecoration(
      counterText: "",
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1,color: ColorConstant.kBlueColor),
          borderRadius: BorderRadius.circular(5)
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1,color: ColorConstant.greyTextColor),
          borderRadius: BorderRadius.circular(5)
      )
  );




}