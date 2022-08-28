import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/graph_time_widget.dart';
import 'package:digi3map/screens/group_portle/provider/leaderboard_player.dart';
import 'package:digi3map/screens/group_portle/widget/leaderboard_winner_points.dart';
import 'package:digi3map/screens/group_portle/widget/others_leaderboard_widget.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class FriendlyCompetition extends StatelessWidget {
  const FriendlyCompetition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          padding: Constants.kPagePaddingNoDown,
          child: Column(
            children: [
              Text(
                "Compete With Those You Follow",
                style: Styles.bigHeading,
              ),
              Constants.kSmallBox,
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(
                    child: Text(
                        "No Price Competition",
                      style: Styles.opacityHeadingStyle,
                    ),
                  ),
                  Expanded(
                  child:FittedBox(
                      child: GraphTimeFrame()
                  ) ,
                  )
                ],
              ),
              Constants.kSmallBox,
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Text(
                        "Top 10 Followers",
                      style: Styles.mediumHeading,
                    ),
                    for(int i=0;i<10;i++)
                      TopPlayerWidget(players: LeaderboardPlayers(userId: 1, userName: "Aradhya Nepal", userCoin: 100, isAnonymous: true),),
                    Text(
                        "Others",
                      style: Styles.mediumHeading,
                    ),
                    for(int i=0;i<10;i++)
                      OthersLeaderboardIndividual(player: LeaderboardPlayers(userId: 1, userName: "Aradhya Nepal", userCoin: 100, isAnonymous: true),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
