import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/logo_widget.dart';
import 'package:digi3map/screens/group_portle/provider/leaderboard_player.dart';
import 'package:digi3map/screens/group_portle/provider/leaderboard_provider.dart';
import 'package:digi3map/screens/group_portle/view/congratulation_page.dart';
import 'package:digi3map/screens/group_portle/widget/leaderboard_drawer.dart';
import 'package:digi3map/screens/group_portle/widget/leaderboard_winner_points.dart';
import 'package:digi3map/screens/group_portle/widget/others_leaderboard_widget.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class LeaderboardInGroup extends StatefulWidget {
  const LeaderboardInGroup({Key? key}) : super(key: key);

  @override
  State<LeaderboardInGroup> createState() => _LeaderboardInGroupState();
}

class _LeaderboardInGroupState extends State<LeaderboardInGroup> {
  bool openAnotherPage=true;
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return ChangeNotifierProvider<LeaderboardProvider>(
      create: (context)=>LeaderboardProvider(),
      child: SafeArea(
        child: Consumer<LeaderboardProvider>(
          builder: (context,provider,child) {
            return Scaffold(
              endDrawer: Drawer(child: LeaderBoardDrawer()),
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.black),
                elevation: 0,
                backgroundColor: Colors.white,
                title:  const SizedBox(
                    height: 30,
                    width: 100,
                    child: FittedBox(
                        child: LogoWidget()
                    )
                ),
              ),
              body: Container(
                height: size.height,
                width: size.width,
                padding: Constants.kPagePaddingNoDown,
                child: Builder(
                  builder: (context) {
                    if(provider.isLoading){
                      return const Center(
                        child: CustomCircularIndicator(),
                      );
                    }
                    if(provider.unCollectedTrophy.isNotEmpty && openAnotherPage){
                      openAnotherPage=false;
                      SchedulerBinding.instance!.addPostFrameCallback((_) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context)=>CongratulationPage(
                                  winnerLeaderBoardIds: provider.unCollectedTrophy,
                                )
                            )
                        );
                      });
                    }
                    if(provider.waiting){

                      return const Center(
                        child: Text(
                          "Waiting For Other Players To Join"
                        ),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                            "Monthly Leaderboard",
                          style: Styles.bigHeading,
                        ),
                        Constants.kSmallBox,
                        const Text(
                          "Top Player",
                          style: Styles.mediumHeading,
                        ),
                        Constants.kVerySmallBox,
                        Builder(
                          builder: (context) {
                            LeaderboardPlayers? player=provider.winnerPlayer;
                            if(player==null) return const SizedBox();
                            return TopPlayerWidget(
                              players: player,
                            );
                          }
                        ),
                        Constants.kSmallBox,
                        const Text(
                          "Others",
                          style: Styles.mediumHeading,
                        ),
                        Constants.kVerySmallBox,
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              List<LeaderboardPlayers> playersList=provider.otherPlayers;
                              return ListView.builder(
                                physics: BouncingScrollPhysics(),
                                  itemBuilder:(context,i){
                                    return OthersLeaderboardIndividual(player: playersList[i]);
                                  },
                                itemCount: playersList.length,
                              );
                            }
                          )
                        )
                      ],
                    );
                  }
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
