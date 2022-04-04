
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/group_portle/provider/leaderboard_player.dart';
import 'package:digi3map/screens/group_portle/widget/user_popup_testing.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OthersLeaderboardIndividual extends StatelessWidget {
  LeaderboardPlayers player;
  OthersLeaderboardIndividual({
    required this.player,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    showDialog(

                        context: context,
                        builder: (_){
                          return
                            NormalLeaderBoardWidget();
                        }
                    );
                  },
                  child:ClipOval(
                    child: SizedBox(
                      height: 50,
                      child: player.userImage==null|| player.userImage==""?Image.asset(
                          AssetsLocation.userDummyProfileLocation
                      ):Image.network(
                          Service.baseApi+"media/"+(player.userImage??"")
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20,),
              Expanded(
                flex: 3,
                child:Column(
                  children: [
                    Text(
                      player.userName.substring(0,1).toUpperCase()+player.userName.substring(1).toLowerCase(),
                      style: Styles.smallHeading,
                    ),
                    player.isUser?Text(
                      "(You)",
                      style: TextStyle(
                          color: Colors.black
                      ),
                    ):SizedBox(),
                  ],
                )
              ),
              SizedBox(width: 20,),
              Expanded(
                child: Text(
                  player.userCoin.toString(),
                  style: Styles.mediumHeading,
                ),
              ),

              SizedBox(width: 10,),
              SvgPicture.asset(
                AssetsLocation.coinIconLocation,
                height: 30,
                width: 30,
              ),


            ],
          ),
        ),
      ),
    );
  }
}
