import 'package:digi3map/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBlueButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  CustomBlueButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 65,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: ColorConstant.kBlueColor),
          onPressed: onPressed,
          child: Text(
              text,
            style: GoogleFonts.poppins(
              fontSize: 20
            )
          )
      ),
    );
  }
}


