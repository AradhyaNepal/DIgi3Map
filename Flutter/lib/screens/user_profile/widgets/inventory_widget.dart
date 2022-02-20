
import 'package:digi3map/data/models/effects_model.dart';
import 'package:digi3map/screens/user_profile/view/user_self_profile.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

import 'inventory_individual.dart';

class InventoryWidget extends StatelessWidget {
  final List<int> effectCount=[5,3,4,0,1];
  InventoryWidget({
    Key? key,
  }) : super(key: key);

  bool isAllEmpty(){
    for(int i in effectCount){
      if(i>0) return false;
    }
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return isAllEmpty()?SizedBox():Column(
      children: [
        Row(
          children: [
            Text(
              "Inventory",
              style: Styles.mediumHeading,
            ),
            SizedBox(width: 10,),
            Text(
              "*Private Details",
              style: Styles.opacityHeadingStyle,
            )
          ],
        ),
        for(int i=0;i<effectCount.length;i++)
          InventoryEffectIndividual(
            count: effectCount[i],
            effectModel: EffectData.effectData[i],
          )
      ],
    );
  }
}
