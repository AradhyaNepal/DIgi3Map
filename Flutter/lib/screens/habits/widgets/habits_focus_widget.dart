
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class HabitFocusWidget extends StatelessWidget {
  final int days;
  const HabitFocusWidget({
    required this.days,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool goodChain=false;
    if(days>=15) goodChain=true;
    return Container(
      padding:const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
      color: goodChain?Colors.green.withOpacity(0.4):Colors.red.withOpacity(0.4),
      child: FittedBox(
        child: Column(
          children: [
            Row(
              children: [
                Text('$days%',style: Styles.mediumHeading,),
                Icon(

                  goodChain?Icons.check:Icons.close,
                  color: goodChain?Colors.green:Colors.red,
                  size: 30,
                )
              ],
            ),
            Text(
              goodChain?'Good Chain':'Bad Chain',
              textAlign: TextAlign.center,
              style: Styles.blueHighlight,
            )
          ],
        ),
      ),
    );
  }
}

