
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class FollowerWidget extends StatefulWidget {
  const FollowerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<FollowerWidget> createState() => _FollowerWidgetState();
}

class _FollowerWidgetState extends State<FollowerWidget> {
  int follower=10;
  bool followed=false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Followers: $follower",
          style: Styles.mediumHeading,
        ),
        SizedBox(width: 10,),
        ElevatedButton(
            onPressed: (){
              if(followed){
                follower--;
              }
              else{
                follower++;
              }
              followed=!followed;
              setState(() {

              });
            },
            child: Text(
              followed?"Unfollow":"Follow",
              style: Styles.mediumHeading,
            )
        )
      ],
    );
  }
}
