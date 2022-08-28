
import 'package:digi3map/theme/colors.dart';
import 'package:flutter/material.dart';

class IndexUnit extends StatelessWidget {
  final bool balancedDetail;
  const IndexUnit({
    required this.balancedDetail,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: balancedDetail?
              ColorConstant.kLightGreenColor:
              ColorConstant.kLightRedColor,
              borderRadius: BorderRadius.circular(5)
          ),

        ),
        const SizedBox(width: 10,),
        Text(
          balancedDetail?
          "Balanced":
          "Over Or Under Focused",
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorConstant.kLightWhiteColor
          ),
        ),
        const SizedBox(width: 10,),
      ],
    );
  }
}