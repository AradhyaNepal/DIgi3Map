
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/provider/chain_provider.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/view/habits_chain_page.dart';
import 'package:digi3map/screens/habits/widgets/habits_focus_widget.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class OpenChainNavigationWidget extends StatelessWidget {
  final int habitId;
  final String habitName;
  const OpenChainNavigationWidget({
    required this.habitId,
    required this.habitName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      child: Row(
        children:  [
          Expanded(
              flex:3,
              child: FutureBuilder<int>(
                future: ChainProvider(habitId: habitId,fromMileStone: false).getChain(),
                builder: (context,snapShot) {
                  if(snapShot.connectionState==ConnectionState.waiting){
                    return Center(
                      child: CustomCircularIndicator(),
                    );
                  }
                  return HabitFocusWidget(

                    days:snapShot.data??0 ,
                  );
                }
              )
          ),
          Spacer(),
          Expanded(
              flex: 4,
              child: TextButton(
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  HabitChain(habitId: habitId,habitName: habitName,)));
                },
                child: Text(
                  'Open Chain >>',
                  textAlign: TextAlign.right,
                ),
              )
          ),
          SizedBox(width: 10,)
        ],
      ),
    );
  }
}

