
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_alert_dialog.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/group_portle/provider/group_chat_provider.dart';
import 'package:digi3map/screens/user_profile/view/user_others_profile.dart';
import 'package:digi3map/screens/user_profile/widgets/follower_widget.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';


class UserProfilePopupTesting extends StatelessWidget {

  UserProfilePopupTesting({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          color: Colors.red,
          padding: Constants.kPagePadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                AnonyGroupWidget(),
                Constants.kSmallBox,
                NormalGroupWidget(),
                Constants.kSmallBox,
                NormalLeaderBoardWidget(),
                Constants.kSmallBox,
                AnonymousLeaderBoardWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnonyGroupWidget extends StatefulWidget {
  final ChatModel? chatModel;

  AnonyGroupWidget({
    this.chatModel,
    Key? key,
  }) : super(key: key);

  @override
  State<AnonyGroupWidget> createState() => _AnonyGroupWidgetState();
}

class _AnonyGroupWidgetState extends State<AnonyGroupWidget> {
  bool isReporting=false;

  final normalBorder=Radius.circular(30);

  final spikeBorder=Radius.circular(5);

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Anonymoys User",
                style: Styles.bigHeading,
              ),
              Constants.kVerySmallBox,
              Text(
                widget.chatModel!=null?widget.chatModel!.username:"Aradhya Nepal",
                style: Styles.mediumHeading,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Group Score : 500",
                    style: Styles.smallHeading,
                  ),
                  SizedBox(width: 5,),
                  SvgPicture.asset(
                      AssetsLocation.coinIconLocation,
                    height: 30,
                    width: 30,
                  )
                ],
              ),
              Text(
                "Rank: 5th",
                style: Styles.smallHeading,
              ),
              FollowerWidget(),
              Consumer<GroupChatProvider>(
                builder: (context,provider,child) {
                  return isReporting?
                  Center(
                    child: CustomCircularIndicator(),
                  ):ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: (){
                      showDialog(
                          context: context,
                          builder: (context){
                            return CustomAlertDialog(
                                heading: "Report",
                                subText: "Do You Really Want To Report The User"
                            );
                          }
                      ).then((value) async{
                        if(value==true){

                          if(widget.chatModel!=null){
                            setState(() {
                              isReporting=true;
                            });
                            try{

                              await provider.reportUser(widget.chatModel!.userId);
                              CustomSnackBar.showSnackBar(context,"Successfully Reported");

                            }catch (e){
                              CustomSnackBar.showSnackBar(context, e.toString());
                            }
                            setState(() {
                              isReporting=false;
                            });
                          }




                        }
                      });
                      },
                      child: Text("Report")
                  );
                }
              )


            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: normalBorder,
              topLeft: normalBorder,
              bottomRight: normalBorder,
              bottomLeft: normalBorder,
            )

          ),
        )
      ],
    );
  }
}


class NormalGroupWidget extends StatefulWidget {
  final ChatModel? chatModel;
  NormalGroupWidget({
    this.chatModel,
    Key? key,
  }) : super(key: key);

  @override
  State<NormalGroupWidget> createState() => _NormalGroupWidgetState();
}

class _NormalGroupWidgetState extends State<NormalGroupWidget> {
  final normalBorder=Radius.circular(30);

  final spikeBorder=Radius.circular(5);
  bool isReporting=false;

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Text(
                widget.chatModel!=null?widget.chatModel!.username:"Kiran Don",
                style: Styles.bigHeading,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Group Score : 500",
                    style: Styles.smallHeading,
                  ),
                  SizedBox(width: 5,),
                  SvgPicture.asset(
                    AssetsLocation.coinIconLocation,
                    height: 30,
                    width: 30,
                  )
                ],
              ),
              Text(
                "Rank: 5th",
                style: Styles.smallHeading,
              ),
              FollowerWidget(),
              ElevatedButton(
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserOtherProfile(
                        )));
                  },
                  child: Text("View Profile")
              ),
              Consumer<GroupChatProvider>(
                builder: (context,provider,child) {
                  return isReporting?
                  Center(
                    child: CustomCircularIndicator(),
                  ):ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (context){
                              return CustomAlertDialog(heading: "Report", subText: "Do You Really Want To Report The User");
                            }
                        ).then((value)  async{
                          if(widget.chatModel!=null){
                            setState(() {
                              isReporting=true;
                            });
                            try{

                              await provider.reportUser(widget.chatModel!.userId);

                              CustomSnackBar.showSnackBar(context,"Successfully Reported");

                            }catch (e){
                              CustomSnackBar.showSnackBar(context, e.toString());
                            }
                            setState(() {
                              isReporting=false;
                            });
                          }
                        });
                      },
                      child: Text("Report")
                  );
                }
              ),


            ],
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: normalBorder,
                topLeft: normalBorder,
                bottomRight: normalBorder,
                bottomLeft: normalBorder,
              )

          ),
        )
      ],
    );
  }
}

class NormalLeaderBoardWidget extends StatelessWidget {
  NormalLeaderBoardWidget({
    Key? key,
  }) : super(key: key);

  final normalBorder=Radius.circular(30);
  final spikeBorder=Radius.circular(5);

  @override
  Widget build(BuildContext context) {

    final size=MediaQuery.of(context).size;
    return Padding(
      padding:EdgeInsets.only(top: size.height*0.3),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text(
                  "Kiran Acharya",
                  style: Styles.bigHeading,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Group Score : 500",
                      style: Styles.smallHeading,
                    ),
                    SizedBox(width: 5,),
                    SvgPicture.asset(
                      AssetsLocation.coinIconLocation,
                      height: 30,
                      width: 30,
                    )
                  ],
                ),
                Text(
                  "Rank: 5th",
                  style: Styles.smallHeading,
                ),

                FollowerWidget(),
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => UserOtherProfile(
                          )));
                    },
                    child: Text("View Profile")
                ),


              ],
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: normalBorder,
                  topLeft: normalBorder,
                  bottomRight: normalBorder,
                  bottomLeft: normalBorder,
                )

            ),
          )
        ],
      ),
    );
  }
}


class AnonymousLeaderBoardWidget extends StatelessWidget {
  AnonymousLeaderBoardWidget({
    Key? key,
  }) : super(key: key);

  final normalBorder=Radius.circular(30);
  final spikeBorder=Radius.circular(5);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text(
                  "Anonymoys User",
                  style: Styles.bigHeading,
                ),
                Constants.kVerySmallBox,
                Text(
                  "Kiran Acharya",
                  style: Styles.mediumHeading,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Group Score : 500",
                      style: Styles.smallHeading,
                    ),
                    SizedBox(width: 5,),
                    SvgPicture.asset(
                      AssetsLocation.coinIconLocation,
                      height: 30,
                      width: 30,
                    )
                  ],
                ),
                Text(
                  "Rank: 5th",
                  style: Styles.smallHeading,
                ),

                FollowerWidget(),



              ],
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: normalBorder,
                  topLeft: normalBorder,
                  bottomRight: normalBorder,
                  bottomLeft: normalBorder,
                )

            ),
          )
        ],
      ),
    );
  }
}
