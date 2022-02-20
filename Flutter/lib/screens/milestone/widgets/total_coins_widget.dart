import 'package:digi3map/screens/milestone/widgets/coin_value_widget.dart';
import 'package:flutter/material.dart';

class TotalCoinsWidget extends StatelessWidget {
  const TotalCoinsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Points\nCollected",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(width: 10,),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4)
          ),
          child: CoinValueWidget(value:50,),
        )

      ],
    );
  }
}
