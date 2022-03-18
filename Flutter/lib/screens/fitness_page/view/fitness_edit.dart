import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/domain_crud/widget/image_picker.dart';
import 'package:digi3map/screens/domain_crud/widget/profile_heading_editable_widget.dart';
import 'package:digi3map/screens/fitness_page/widgets/improve_in_progress.dart';
import 'package:digi3map/screens/fitness_page/widgets/rep_weight_rest_editadd.dart';
import 'package:digi3map/screens/fitness_page/widgets/set_reps_items_widget.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class FitnessEditAdd extends StatelessWidget {
  final bool forAdding;
  FitnessEditAdd({
    this.forAdding=false,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          padding: Constants.kPagePaddingNoDown,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Set And Reps",
                style: Styles.bigHeading,
              ),
              Constants.kSmallBox,
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomImagePicker(
                          imageLocation: ValueNotifier(
                              forAdding?null:AssetsLocation.deadLiftImageLocation
                          )
                      ),

                      Constants.kSmallBox,
                      ProfileHeadingEditableWidget(
                        value: ValueNotifier("Deadlift"),
                        openedByDefault: forAdding,
                      ),

                      Constants.kVerySmallBox,
                      SetRepItemsWidget(
                        values: forAdding?[]:[50,55,60,65,70],
                      ),
                      Constants.kVerySmallBox,
                      ImproveInProgressWidget(),
                      
                      Constants.kSmallBox,
                      CustomBlueButton(
                          text: forAdding?"Add":"Save Changes",
                          onPressed: (){

                          }
                      ),
                      Constants.kSmallBox,
                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
