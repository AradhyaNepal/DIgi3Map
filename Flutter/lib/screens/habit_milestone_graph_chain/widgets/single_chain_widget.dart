
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class SingleChainWidget extends StatelessWidget {
  final int dayNumber;
  const SingleChainWidget({
    required this.dayNumber,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AssetsLocation.chainImageLocation,
          width: 175,
        ),
        Positioned.fill(
          child: Center(
            child: RotatedBox(
              quarterTurns: -1,
              child: Text(
                "Day $dayNumber",
                style: Styles.mediumHeading,

              ),
            ),
          ),
        )
      ],
    );
  }
}
