
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/screens/group_portle/provider/group_chat_provider.dart';
import 'package:digi3map/screens/group_portle/view/group_call.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JoinCallWidget extends StatelessWidget {
  final normalBorder=Radius.circular(50);
  final spikeBorder=Radius.circular(0);
  JoinCallWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal:Constants.kPaddingValue),
      padding: const EdgeInsets.all(20),

      child: Row(
        children: [
          Flexible(
              flex: 2,
              child: Text(
                "There is a group call going on",
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.white
                ),
              )
          ),
          SizedBox(width: 10,),
          TextButton(
              onPressed: (){

                final provider=Provider.of<GroupChatProvider>(context,listen:false);


                GroupCall.openGroupCallPage(context,provider);
              },
              child: Text(
                  "Join +",
                  style: Styles.bigHeading
              )
          )
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              topLeft: normalBorder,
              topRight: normalBorder,
              bottomLeft: spikeBorder,
              bottomRight: normalBorder
          )
      ),
    );
  }
}
