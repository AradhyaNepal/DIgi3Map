
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoinValueWidget extends StatelessWidget {
  final int value;
  const CoinValueWidget({
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          AssetsLocation.coinIconLocation,
          height: 40,
          width: 40,
        ),
        SizedBox(width: 4,),
        Text(
          "✖",
          style: TextStyle(
              fontSize: 10
          ),
        ),
        Text(
          value.toString(),
          style: Styles.bigHeading,
        )
      ],
    );
  }
}
