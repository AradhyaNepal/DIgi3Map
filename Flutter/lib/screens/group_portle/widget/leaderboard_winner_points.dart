
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/group_portle/provider/leaderboard_player.dart';
import 'package:digi3map/screens/group_portle/widget/user_popup_testing.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopPlayerWidget extends StatelessWidget {
  final LeaderboardPlayers players;
  TopPlayerWidget({
    required this.players,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
              child: GestureDetector(
                onTap: (){
                  showDialog(

                      context: context,
                      builder: (_){
                        return
                          AnonymousLeaderBoardWidget();
                      }
                  );
                },
                child: Image.asset(
                    AssetsLocation.userDummyProfileLocation),
              )
          ),
          SizedBox(width: 10,),
          Expanded(
              flex: 2,
              child: FittedBox(
                child: Column(
                  children: [
                    Text(
                      players.userName,
                      style: Styles.bigWhiteHeading,
                    ),
                    players.isUser?Text(
                      "(You)",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ):SizedBox(),
                  ],
                ),
              )
          ),
          SizedBox(width: 10,),
          Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      players.userCoin.toString(),
                      style: Styles.bigWhiteHeading,
                    ),
                  ),

                  SizedBox(width: 5,),
                  SvgPicture.asset(
                    AssetsLocation.coinIconLocation,
                    height: 30,
                    width: 30,
                  )
                ],
              )
          ),
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
              colors: ColorConstant.kTopPlayerColors
          )
      ),
    );
  }
}
