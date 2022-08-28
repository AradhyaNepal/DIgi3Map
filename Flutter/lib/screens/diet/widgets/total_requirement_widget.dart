
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class TotalRequirementWidget extends StatelessWidget {
  const TotalRequirementWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Total Requirement",
          style: Styles.smallHeading,
        ),
        Constants.kVerySmallBox,
        Text(
          "Calorie: 2500 kcal",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        Constants.kVerySmallBox,
        Text(
          "Carbs: 100 gm",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        Constants.kVerySmallBox,
        Text(
          "Protein: 100 gm",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        Constants.kVerySmallBox,
        Text(
          "Fat: 100 gm",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        Constants.kVerySmallBox,
      ],
    );
  }
}
