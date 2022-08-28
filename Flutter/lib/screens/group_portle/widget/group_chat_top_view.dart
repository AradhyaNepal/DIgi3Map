
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/group_portle/provider/group_chat_provider.dart';
import 'package:digi3map/screens/group_portle/view/group_call.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupChatTopView extends StatelessWidget {
  final borderValue=Radius.circular(30);
  GroupChatTopView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool callIsOn=Provider.of<GroupChatProvider>(context,listen: true).callIsOn;
    final size=MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft:borderValue,
          bottomRight: borderValue,
        ),
        color: Colors.black,
      ),
      child: Row(
        children: [
          Icon(Icons.chevron_left,color: Colors.white,),
          Spacer(),
          Column(
            children: [
              SizedBox(height: 10,),
              Text(
                "Group Portal",
                style: TextStyle(
                    fontFamily: AssetsLocation.twCenName,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white
                ),
              ),
              Consumer<GroupChatProvider>(
                builder: (context,provider,child) {
                  return Text(
                    "5 Players Online now",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  );
                }
              ),
              SizedBox(height: 10,),
            ],
          ),
          Spacer(),
          callIsOn?
          Column(
            children: [
              TextButton(
                  onPressed: (){
                    final provider=Provider.of<GroupChatProvider>(context,listen:false);


                    GroupCall.openGroupCallPage(context,provider);
                  },
                  child: Text(
                    "Join +",
                    style: Styles.bigHeading,
                  )
              ),
              Text(
                  "Players:3",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ],
          ):
          IconButton(
            onPressed: (){
              final provider=Provider.of<GroupChatProvider>(context,listen:false);
              provider.callStarted();

              GroupCall.openGroupCallPage(context,provider);
              },
            icon: Icon(
              Icons.phone_outlined,
              color: Colors.red,
            ),
          ),

        ],
      ),
    );
  }
}
