
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/screens/homepage/widgets/energy_filter_widget.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Total Time (2 Hour)",
          style: Styles.smallHeading,
        ),
        Spacer(),
        TextButton(
            onPressed: (){
              showModalBottomSheet(
                  context: context,
                  builder: (context)=>EnergyFilterWidget()
              );
            },
            child: Text(
              "Energy Filter",
              style: Styles.blueHighlight,
            )
        ),

        Constants.kVerySmallBox,
      ],
    );
  }
}
