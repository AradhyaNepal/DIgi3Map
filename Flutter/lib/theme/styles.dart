import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:flutter/cupertino.dart';
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


}