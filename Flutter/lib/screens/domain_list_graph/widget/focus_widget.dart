
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class FocusWidget extends StatelessWidget {
  final int percentage;
  const FocusWidget({
    required this.percentage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isBalanced=false;
    if(percentage>=20 && percentage<=30) isBalanced=true;
    return Container(
      padding:const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
      color: isBalanced?Colors.green.withOpacity(0.4):Colors.red.withOpacity(0.4),
      child: FittedBox(
        child: Column(
          children: [
            Row(
              children: [
                Text('$percentage%',style: Styles.mediumHeading,),
                Icon(

                  isBalanced?Icons.check:Icons.close,
                  color: isBalanced?Colors.green:Colors.red,
                  size: 30,
                )
              ],
            ),
            Text(
              isBalanced?'Balanced':'Over Focus',
              textAlign: TextAlign.center,
              style: Styles.blueHighlight,
            )
          ],
        ),
      ),
    );
  }
}
