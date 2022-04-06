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
                child: Card(
                  child: Image.asset(
                      diet.image
                  ),
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
          Row(
            children: [
              Flexible(
                child: Text(
                    "${diet.id}) ${diet.name}",
                  style: Styles.mediumHeading,
                ),
              ),
              IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.edit,
                  color: ColorConstant.kIconColor,
                ),
              )
            ],
          ),
          Text(
            diet.description
          ),
          Constants.kSmallBox,
          FailedSuccessDietWidget(dietId: diet.id,),

        ],
      );
    }
    else{
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  "${diet.id}) ${diet.name}",
                  style: Styles.mediumHeading,
                ),
              ),
              IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.edit,
                  color: ColorConstant.kIconColor,
                ),
              ),
            ],
          ),

          Text("Protein Intake:${diet.protein}"),
          Text("Fat Intake:${diet.fat}"),
          Text("Carbs Intake:${diet.carbs}"),
          Constants.kSmallBox,
          FailedSuccessDietWidget(dietId: diet.id,),
        ],
      );
    }
  }
}
