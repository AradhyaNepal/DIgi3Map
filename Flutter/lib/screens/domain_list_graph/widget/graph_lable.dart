import 'package:digi3map/theme/colors.dart';
import 'package:flutter/material.dart';

class GraphLable extends StatelessWidget {
  final int min;
  final int max;
  final int gap;
  const GraphLable({
    required this.min,
    required this.max,
    required this.gap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Max:$max\nMin:$min");
    return Column(
      children: [
        Text(
          max.toString(),
          style: TextStyle(
              color: ColorConstant.kLightWhiteColor
          ),
        ),
        for(int i=max-gap;i>=min;i-=gap)
          Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  i.toString(),
                  style: const TextStyle(
                      color: ColorConstant.kLightWhiteColor
                  ),
                ),
              )
          ),
      ],
    );
  }
}
