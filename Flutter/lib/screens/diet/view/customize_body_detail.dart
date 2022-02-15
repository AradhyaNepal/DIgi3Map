import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/common/widgets/selection_collection.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomBodyDetails extends StatelessWidget {
  const CustomBodyDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          padding: Constants.kPagePaddingNoDown,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Customize Body Details",
                  style: Styles.bigHeading,
                ),
                Constants.kSmallBox,
                TotalRequirementWidget(),
                Divider(
                  thickness: 2,
                  color: Colors.grey,
                ),
                Constants.kSmallBox,
                ScrollableChoosing(
                  heading: "Weight",
                ),
                Constants.kSmallBox,
                ScrollableChoosing(
                  heading: "Muscle Mass",
                ),
                Constants.kSmallBox,
                Text(
                    'Body Type',
                  style: Styles.blueHighlight,
                ),
                Constants.kVerySmallBox,
                SelectionCollection(
                    valuesList: [
                      "Fat",
                      "Skinny",
                      "Muscular",
                      "Skinny Fat",
                      "Anabolic"
                    ]
                ),

                Constants.kSmallBox,
                ScrollableChoosing(
                    heading: "Sleep Hour",
                  unit: "Hours",
                  min: 2,
                  max: 24,
                ),
                Constants.kSmallBox,
                Text(
                  "Daily Physical Intensity",
                  style: Styles.blueHighlight,
                ),
                Constants.kVerySmallBox,
                SelectionCollection(
                    valuesList: [
                      "Sedentary",
                      "Active",
                      "Extreme"
                    ]
                ),

                Constants.kSmallBox,
                CustomBlueButton(
                    text: "Done",
                    onPressed: (){
                      Navigator.pop(context);
                    }
                ),

                Constants.kSmallBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
