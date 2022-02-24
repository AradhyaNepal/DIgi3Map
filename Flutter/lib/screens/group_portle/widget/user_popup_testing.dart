
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/user_profile/widgets/follower_widget.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


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

class AnonyGroupWidget extends StatelessWidget {
  AnonyGroupWidget({
    Key? key,
  }) : super(key: key);

  final normalBorder=Radius.circular(30);
  final spikeBorder=Radius.circular(5);

  @override
  Widget build(BuildContext context) {

    return Column(
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
                    style: Styles.mediumHeading,
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
                style: Styles.mediumHeading,
              ),
              Constants.kSmallBox,
              FollowerWidget(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: (){},
                  child: Text("Report")
              )


            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: normalBorder,
              topLeft: normalBorder,
              bottomRight: normalBorder,
              bottomLeft: spikeBorder,
            )

          ),
        )
      ],
    );
  }
}


class NormalGroupWidget extends StatelessWidget {
  NormalGroupWidget({
    Key? key,
  }) : super(key: key);

  final normalBorder=Radius.circular(30);
  final spikeBorder=Radius.circular(5);

  @override
  Widget build(BuildContext context) {

    return Column(
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
                    style: Styles.mediumHeading,
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
                style: Styles.mediumHeading,
              ),
              Constants.kSmallBox,
              ElevatedButton(
                  onPressed: (){},
                  child: Text("View Profile")
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: (){},
                  child: Text("Report")
              ),


            ],
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: normalBorder,
                topLeft: normalBorder,
                bottomRight: normalBorder,
                bottomLeft: spikeBorder,
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

    return Column(
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
                    style: Styles.mediumHeading,
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
                style: Styles.mediumHeading,
              ),

              Constants.kSmallBox,
              FollowerWidget(),
              ElevatedButton(
                  onPressed: (){},
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
                bottomLeft: spikeBorder,
              )

          ),
        )
      ],
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

    return Column(
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
                    style: Styles.mediumHeading,
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
                style: Styles.mediumHeading,
              ),

              Constants.kSmallBox,
              FollowerWidget(),



            ],
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: normalBorder,
                topLeft: normalBorder,
                bottomRight: normalBorder,
                bottomLeft: spikeBorder,
              )

          ),
        )
      ],
    );
  }
}
