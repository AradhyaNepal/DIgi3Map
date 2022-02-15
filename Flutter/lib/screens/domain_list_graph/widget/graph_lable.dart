import 'package:digi3map/theme/colors.dart';
import 'package:flutter/material.dart';

class GraphLable extends StatelessWidget {
  const GraphLable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '100',
          style: TextStyle(
              color: ColorConstant.kLightWhiteColor
          ),
        ),
        for(int i=75;i>=0;i-=25)
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
