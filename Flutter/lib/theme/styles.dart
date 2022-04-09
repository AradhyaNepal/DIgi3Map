import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/theme/colors.dart';
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

  static const TextStyle lightWhiteTextStyle=TextStyle(
      color: ColorConstant.kLightWhiteColor,
      fontWeight: FontWeight.bold
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

  static const TextStyle bigWhiteHeading=TextStyle(
      fontFamily: AssetsLocation.twCenName,
      fontWeight: FontWeight.bold,
      fontSize: 25,
      color: Colors.white
  );


  static const TextStyle mediumHeading=TextStyle(
      fontFamily: AssetsLocation.twCenName,
      fontWeight: FontWeight.bold,
      fontSize: 20
  );
  static const TextStyle smallHeading=TextStyle(
      fontFamily: AssetsLocation.twCenName,
      fontWeight: FontWeight.bold,
      fontSize: 15
  );

  static const TextStyle semiMedium=TextStyle(
      fontFamily: AssetsLocation.twCenName,
      fontWeight: FontWeight.bold,
      fontSize: 19
  );

  static const TextStyle blueHighlight=TextStyle(
    color: Colors.blue,
      fontFamily: AssetsLocation.twCenName,
      fontWeight: FontWeight.bold,
      fontSize: 15
  );

  static TextStyle forgotPasswordStyle=GoogleFonts.roboto(
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.w500

  );

  static TextStyle opacityHeadingStyle=GoogleFonts.roboto(
      color: ColorConstant.kBlueColor.withOpacity(0.5),
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

  static InputDecoration getDecorationWithLable(String lable){
    return  InputDecoration(
      alignLabelWithHint: true,
        label: Text(lable),
        focusedErrorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.red,width: 1)
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.red,width: 1)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.blueAccent,width: 1)
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.black,width: 1)
        )
    );
  }
  static InputDecoration pinDecoration=InputDecoration(
      counterText: "",
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1,color: ColorConstant.kBlueColor),
          borderRadius: BorderRadius.circular(5)
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1,color: ColorConstant.kGreyTextColor),
          borderRadius: BorderRadius.circular(5)
      )
  );




}