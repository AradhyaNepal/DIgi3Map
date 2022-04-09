
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_alert_dialog.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/common/widgets/logo_widget.dart';
import 'package:digi3map/screens/authentication/provides/auth.dart';
import 'package:digi3map/screens/effect_shop/view/shop_page.dart';
import 'package:digi3map/screens/group_portle/view/friendly_competition.dart';
import 'package:digi3map/screens/group_portle/view/group_chat.dart';
import 'package:digi3map/screens/homepage/views/splash_page.dart';
import 'package:digi3map/screens/settings/settings.dart';
import 'package:digi3map/screens/user_profile/view/user_self_profile.dart';
import 'package:flutter/material.dart';

class LeaderBoardDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        key: key,
        body: Container(
          height:height,
          padding: Constants.kPagePadding,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                    width: double.infinity,
                    height: height*0.3,
                    child: FittedBox(
                        child: LogoWidget()
                    )
                ),

                Card(
                  elevation: 5,
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>  UserSelfProfile()));
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      title: Text("Profile"),
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>  GroupChat()));
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.message,
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      title: Text("Group Chat"),
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>  ShopPage()));
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.attach_money,
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      title: Text("Effect Shop"),
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>  FriendlyCompetition()));
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.emoji_people_rounded,
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      title: Text("Friendly Leaderboard"),
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>  Settings()));
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.settings,
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      title: Text("Settings"),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

