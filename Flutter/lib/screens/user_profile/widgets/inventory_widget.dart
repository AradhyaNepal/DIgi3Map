
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/data/models/effects_model.dart';
import 'package:digi3map/screens/user_profile/provider/user_profile_provider.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'inventory_individual.dart';

class InventoryWidget extends StatefulWidget {

  InventoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<InventoryWidget> createState() => _InventoryWidgetState();
}

class _InventoryWidgetState extends State<InventoryWidget> {




  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context,provider,child) {
        if(provider.loadingInventory){
          return CustomCircularIndicator();
        }

        return provider.userEffectCount.isEmpty?SizedBox():Column(
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
            for(int i=0;i<provider.userEffectCount.length;i++)
              InventoryEffectIndividual(
                count: provider.userEffectCount[i].count,
                effectModel: EffectData.effectData.firstWhere((element) => element.id==provider.userEffectCount[i].effectId),
              )
          ],
        );
      }
    );
  }
}