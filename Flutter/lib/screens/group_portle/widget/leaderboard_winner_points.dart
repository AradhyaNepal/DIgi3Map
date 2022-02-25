
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopPlayerWidget extends StatelessWidget {
  const TopPlayerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
              child: Image.asset(AssetsLocation.userDummyProfileLocation)
          ),
          SizedBox(width: 10,),
          Expanded(
              flex: 2,
              child: FittedBox(
                child: Column(
                  children: [
                    Text(
                      "Aaradhya Nepal",
                      style: Styles.bigWhiteHeading,
                    ),
                    Text(
                      "(You)",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
              )
          ),
          SizedBox(width: 10,),
          Expanded(
              child: FittedBox(
                child: Row(
                  children: [
                    Text(
                      "100",
                      style: Styles.bigWhiteHeading,
                    ),

                    SizedBox(width: 5,),
                    SvgPicture.asset(
                      AssetsLocation.coinIconLocation,
                      height: 30,
                      width: 30,
                    )
                  ],
                ),
              )
          ),
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
              colors: ColorConstant.kTopPlayerColors
          )
      ),
    );
  }
}
