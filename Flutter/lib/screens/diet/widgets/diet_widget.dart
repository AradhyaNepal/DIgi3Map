
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/data/models/diet_model.dart';
import 'package:digi3map/screens/diet/widgets/failed_success_diet_widget.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class DietWidget extends StatelessWidget {
  final Diet diet;
  const DietWidget({
    required this.diet,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
      color: ColorConstant.kGreyCardColor,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "${diet.id})",
                      style: Styles.mediumHeading,
                    ),
                    Card(
                      child: Image.asset(
                          diet.image
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(width: 5,),
            Expanded(
              flex: 3,
                child: getDietDetails()
            ),
          ],
        ),
      ),
    );
  }

  Widget getDietDetails(){
    if(diet.showDescription){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              diet.name,
            style: Styles.smallHeading,
          ),
          Text(
            diet.description
          ),
          FailedSuccessDietWidget(),

        ],
      );
    }
    else{
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            diet.name,
            style: Styles.smallHeading,
          ),
          Constants.kSmallBox,
          Text("Protein Intake:${diet.protein}"),
          Text("Fat Intake:${diet.fat}"),
          Text("Carbs Intake:${diet.carbs}"),
          Constants.kSmallBox,
          FailedSuccessDietWidget(),
        ],
      );
    }
  }
}
