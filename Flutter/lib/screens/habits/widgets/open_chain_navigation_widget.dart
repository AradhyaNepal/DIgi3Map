
import 'package:digi3map/screens/habit_milestone_graph_chain/view/habits_chain_page.dart';
import 'package:digi3map/screens/habits/widgets/habits_focus_widget.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class OpenChainNavigationWidget extends StatelessWidget {
  const OpenChainNavigationWidget({
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
              child: HabitFocusWidget(days: 16,)
          ),
          Spacer(),
          Expanded(
              flex: 4,
              child: TextButton(
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  HabitChain()));
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

