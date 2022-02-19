import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/common/widgets/selection_collection.dart';
import 'package:digi3map/screens/domain_crud/widget/profile_heading_editable_widget.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class TimeFilterWidget extends StatelessWidget {
   const TimeFilterWidget({
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    double keyboardPadding=MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: Constants.kPagePadding,
      child: Padding(
        padding: EdgeInsets.only(bottom: keyboardPadding),
        child: SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Time Frame',
                style: Styles.bigHeading,
              ),
              Constants.kVerySmallBox,
              const ProfileHeadingEditableWidget(
                leftAlign: true,
                bigHighlight: false,
                value: "11/11/2021 - 11/11/2022",
              ),
              Constants.kVerySmallBox,
              const SelectionCollection(
                  valuesList: [
                    'Leaderboard',
                    'Monthly',
                    'Custom'
                  ]
              ),
              Constants.kVerySmallBox,
              CustomBlueButton(
                  text: "Apply",
                  onPressed: (){
                    Navigator.pop(context);
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}