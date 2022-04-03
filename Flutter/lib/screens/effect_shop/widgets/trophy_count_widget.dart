
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrophyCountWidget extends StatelessWidget {
  final int? count;
  const TrophyCountWidget({
    required this.count,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: Colors.black,width: 1)
        ),
        child: count==null?
        SizedBox(
          height: 40,
          width: 50,
          child: Center(
            child: CustomCircularIndicator(),
          ),
        ):
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AssetsLocation.trophyIconLocation,
              height: 40,
              width: 40,
            ),
            SizedBox(width: 10,),
            Text(
              "✕",
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
                (count??0).toString(),
                style:Styles.bigHeading
            )
          ],
        ),
      ),
    );
  }
}
