
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_alert_dialog.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/common/widgets/logo_widget.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/authentication/provides/auth.dart';
import 'package:digi3map/screens/authentication/views/change_password_oldpass.dart';
import 'package:digi3map/screens/homepage/views/splash_page.dart';
import 'package:digi3map/screens/homepage/widgets/play_sound_switch.dart';
import 'package:digi3map/screens/user_profile/view/user_self_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageDrawer extends StatelessWidget {
  final BuildContext oldContext;
  HomePageDrawer({
    required this.oldContext
  });
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
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.info,
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      title: Text("About App"),
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: InkWell(
                    onTap: (){
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.share,
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      title: Text("Share App"),
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: InkWell(
                    onTap: (){

                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.volume_up,
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      title: Row(
                        children: [
                          Flexible(child: Text("Play Sound On Splash")),
                          SizedBox(width: 10,),
                          PlaySoundSwitch()
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>  ChangePasswordWithOld()));
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.password,
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      title: Text("Change Password"),
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
                          CustomSnackBar.showSnackBar(oldContext, "Successfully Logged Out");
                          Auth().logOut();
                          Navigator.pushReplacement(context,
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
