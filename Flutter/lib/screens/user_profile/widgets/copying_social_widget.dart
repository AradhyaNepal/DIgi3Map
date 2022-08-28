import 'package:digi3map/common/constants.dart';
import 'package:digi3map/data/models/SocialModel.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class CopyingSocialWidget extends StatelessWidget {
  final List<SocialModel> list=[
    SocialModel(platform: "Instagram", username: "anonymoussssssoul"),
    SocialModel(platform: "Facebook", username: "Aaradhya Gopal Nepal"),
    SocialModel(platform: "Github", username: "Aradhya Nepal"),
  ];
  CopyingSocialWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,

      children: [
        Text(
          "Other Socials",
          style: Styles.opacityHeadingStyle,
        ),
        Constants.kVerySmallBox,
        for(int i=0;i<list.length;i++)
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                  child: SelectableText(
                    list[i].platform,
                    style: Styles.smallHeading,
                  )
              ),
              Expanded(
                  child: SelectableText(
                      list[i].username
                  )
              ),
            ],
          )
      ],
    );
  }
}