
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_alert_dialog.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/common/widgets/logo_widget.dart';
import 'package:digi3map/screens/effect_shop/view/shop_page.dart';
import 'package:digi3map/screens/group_portle/view/friendly_competition.dart';
import 'package:digi3map/screens/group_portle/view/group_chat.dart';
import 'package:digi3map/screens/homepage/provides/isLoggedValue.dart';
import 'package:digi3map/screens/homepage/views/splash_page.dart';
import 'package:digi3map/screens/homepage/widgets/play_sound_switch.dart';
import 'package:digi3map/screens/user_profile/view/user_self_profile.dart';
import 'package:digi3map/screens/user_profile/widgets/anonymous_widget.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
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
                      title: Text("Group Chat Portal"),
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
                      showDialog(
                          context: context,
                          builder: (context){
                            return  CustomAlertDialog(heading: "Log Out",subText:  "Do You Really Want To Log Out",);
                          }
                      ).then((value) {
                        if (value==true) {
                          CustomSnackBar.showSnackBar(context, "Successfully Logged Out");
                          IsLoggedValue.loggedOut();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>  SplashPage()));
                        }

                      }
                      );

                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      title: Text("Log Out"),
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

