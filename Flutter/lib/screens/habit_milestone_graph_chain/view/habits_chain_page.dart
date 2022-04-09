import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/provider/chain_provider.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/widgets/broken_chain_widget.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/widgets/multiple_chain_widget.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/widgets/total_coins_widget.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HabitChain extends StatefulWidget {
  final int habitId;
  final String? habitName;

  const HabitChain({required this.habitId, this.habitName, Key? key})
      : super(key: key);

  @override
  State<HabitChain> createState() => _HabitChainState();
}

class _HabitChainState extends State<HabitChain> {
  bool haveCurrent=false;

  List<Chain> remainingChain=[];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => ChainProvider(habitId: widget.habitId),
          child: Consumer<ChainProvider>(builder: (context, provider, child) {
            if (provider.isLoading) {
              return Center(
                child: CustomCircularIndicator(),
              );
            }
            List<Chain> chainList = provider.chainList;

            int currentChainNumber = 0;
            if (Chain.activatedChainIndex != -1) {
              currentChainNumber = chainList[Chain.activatedChainIndex].count;
              print(chainList.length);
              remainingChain.addAll(chainList);
              remainingChain.removeAt(Chain.activatedChainIndex);
              print(chainList.length);


            }
            return Container(
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.habitName ?? "",
                        style: Styles.mediumHeading,
                      ),
                      TotalCoinsWidget(
                        point: provider.chainCoin,
                      ),
                    ],
                  ),
                  Constants.kSmallBox,
                  Expanded(
                      child: chainList.isEmpty
                          ? Center(
                              child: Text("You Have No Chain"),
                            )
                          : SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Current Chain",
                                    style: Styles.mediumHeading,
                                  ),
                                  Constants.kSmallBox,
                                  MultipleChainWidget(
                                    chainNumber: currentChainNumber,
                                  ),
                                  Constants.kSmallBox,
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        "Completed",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                      Expanded(
                                          child: Text(
                                              "$currentChainNumber days / 21 days")),
                                    ],
                                  ),
                                  Constants.kVerySmallBox,
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        "Leaderboard ends",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                      Expanded(
                                          child: Builder(builder: (context) {
                                        DateTime now = DateTime.now();
                                        int todayDay = now.day;
                                        int lastDay =
                                            DateTime(now.year, now.month + 1, 0)
                                                .day;
                                        return Text(
                                            "${lastDay - todayDay} Days");
                                      })),
                                    ],
                                  ),
                                  Constants.kSmallBox,
                                  BrokenChainWidget(
                                      brokenChainDays: remainingChain
                                          .map((e) => e.count)
                                          .toList()),
                                ],
                              ),
                            )),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
