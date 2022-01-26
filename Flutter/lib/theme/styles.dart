import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles{
  Styles._();
  static const TextStyle logoTextStyle=TextStyle(
    fontFamily: AssetsLocation.twCenBoldName,
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: ColorConstant.kBlueColor
  );

  static const TextStyle subLogoTextStyle=TextStyle(
    fontFamily: AssetsLocation.segoescName,
    fontSize: 20,
    color: ColorConstant.kBlueColor
  );

}