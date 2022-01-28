import 'package:digi3map/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomCircularIndicator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: FittedBox(
        child: CircularProgressIndicator(
          color: ColorConstant.kBlueColor,
          backgroundColor: Color(0x00FFFFFF),
        ),
      ),
    );
  }
}
