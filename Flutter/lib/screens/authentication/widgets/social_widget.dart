import 'package:digi3map/common/constants.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialWidget extends StatelessWidget {
  const SocialWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Divider(
                    thickness: 1.7,
                    color: Colors.black,
                  ),
                )
            ),
            Text(
              "OR",
              style: GoogleFonts.openSans(
                  fontSize: 15
              ),
            ),
            const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Divider(

                    thickness: 1.7,
                    color: Colors.black,
                  ),
                )
            ),
          ],
        ),
        Constants.kSmallBox,
        Text(
          'Continue With Social Networks',
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w600
          ),
        ),
        Constants.kSmallBox,
        Row(
          children: [
            const Spacer(),
            SvgPicture.asset(AssetsLocation.googleLogo,height: 50,width: 50,),
            const Spacer(),
            SvgPicture.asset(AssetsLocation.facebookLogo,height: 60,width: 60,),
            const Spacer()
          ],
        )
      ],
    );
  }
}
