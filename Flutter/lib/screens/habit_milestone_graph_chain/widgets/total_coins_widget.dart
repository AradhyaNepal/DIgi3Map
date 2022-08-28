import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/widgets/coin_value_widget.dart';
import 'package:flutter/material.dart';

class TotalCoinsWidget extends StatelessWidget {
  final int? point;
  const TotalCoinsWidget({
    this.point=50,
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
        const SizedBox(width: 10,),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4)
          ), child:point==null?
              CustomCircularIndicator():
              CoinValueWidget(value:point??0,),
        )
      ],
    );
  }
}
