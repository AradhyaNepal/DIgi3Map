import 'package:digi3map/common/constants.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/widgets/broken_chain_widget.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/widgets/multiple_chain_widget.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/widgets/total_coins_widget.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class HabitChain extends StatelessWidget {
  final List<int> brokenChainDays=[10,20,15,10,16,5,2,1,6];
  HabitChain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          padding: Constants.kPagePaddingNoDown,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Habit Chain",
                style: Styles.bigHeading,
              ),
              Constants.kVerySmallBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment:CrossAxisAlignment.center,
                children: [
                  Text(
                    "Workout",
                    style: Styles.mediumHeading,
                  ),
                  TotalCoinsWidget(),

                ],
              ),
              Constants.kSmallBox,
              Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Current Chain",
                          style: Styles.smallHeading,
                        ),
                        Constants.kSmallBox,
                        MultipleChainWidget(
                          chainNumber: 10,
                        ),
                        Constants.kSmallBox,
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                                  "Completed",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                            ),
                            Expanded(
                                child: Text(
                                  "15 days / 21 days"
                                )
                            ),
                          ],
                        ),
                        Constants.kVerySmallBox,
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                                  "Leaderboard ends",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                            ),
                            Expanded(
                                child: Text(
                                    "10 more days"
                                )
                            ),
                          ],
                        ),
                        Constants.kSmallBox,
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Constants.kSmallBox,
                        BrokenChainWidget(brokenChainDays: brokenChainDays),

                      ],
                    ),
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }
}
