import 'package:digi3map/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomCircularIndicator extends StatelessWidget {

  const CustomCircularIndicator({Key? key}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
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
