
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class ScrollableChoosing extends StatefulWidget {
  final String heading;
  final String unit;
  final double max;
  final double min;
  const ScrollableChoosing({
    required this.heading,
    this.unit="Kg",
    this.max=100,
    this.min=30,
    Key? key,
  }) : super(key: key);

  @override
  State<ScrollableChoosing> createState() => _ScrollableChoosingState();
}

class _ScrollableChoosingState extends State<ScrollableChoosing> {

  double value=5;
  @override
  void initState() {
    super.initState();
    value=(widget.max-widget.min)/2;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.heading,
          style: Styles.blueHighlight,
        ),
        Constants.kVerySmallBox,
        Text(
          "$value ${widget.unit}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Slider(
            activeColor: ColorConstant.kBlueColor,
            inactiveColor: ColorConstant.kBlueColor.withOpacity(0.3),
            value: value,
            max: widget.max,
            min: widget.min,
            onChanged: (value) {
              setState(() {
                this.value = value.toInt().toDouble();
              });
            })
      ],
    );
  }
}
