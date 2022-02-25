import 'package:digi3map/common/constants.dart';
import 'package:digi3map/screens/group_portle/widget/leaderboard_winner_points.dart';
import 'package:digi3map/screens/group_portle/widget/others_leaderboard_widget.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class LeaderboardInGroup extends StatelessWidget {
  const LeaderboardInGroup({Key? key}) : super(key: key);

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
                  "Monthly Leaderboard",
                style: Styles.bigHeading,
              ),
              Constants.kSmallBox,
              Text(
                "Top Player",
                style: Styles.mediumHeading,
              ),
              Constants.kVerySmallBox,
              TopPlayerWidget(),
              Constants.kSmallBox,
              Text(
                "Others",
                style: Styles.mediumHeading,
              ),
              Constants.kVerySmallBox,
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [

                    for(int i=0;i<9;i++)
                      OthersLeaderboardIndividual()

                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
