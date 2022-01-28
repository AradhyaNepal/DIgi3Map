
import 'package:flutter/material.dart';

class Constants{
  Constants._();
  static const double kPaddingValue=20;
  static const kPagePadding = EdgeInsets.all(kPaddingValue);
  static const kPagePaddingNoDown = EdgeInsets.only(left: kPaddingValue,right: kPaddingValue,top: kPaddingValue);
  static const kMediumBox=SizedBox(height: 30,width: 30,);
  static const kBigBox=SizedBox(height: 40,width: 40,);
  static const kSmallBox=SizedBox(height: 20,width: 20,);
}