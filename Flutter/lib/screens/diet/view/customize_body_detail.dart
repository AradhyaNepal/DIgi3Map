import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/common/widgets/selection_collection.dart';
import 'package:digi3map/screens/diet/widgets/scrollable_choosing_widget.dart';
import 'package:digi3map/screens/diet/widgets/total_requirement_widget.dart';
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

                    value: ValueNotifier(""),
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

                    value: ValueNotifier(""),
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
