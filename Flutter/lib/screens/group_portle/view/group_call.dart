import 'package:digi3map/common/constants.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/group_portle/provider/group_chat_provider.dart';
import 'package:digi3map/screens/group_portle/widget/players_call_widget.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupCall extends StatelessWidget {
  final GroupChatProvider provider;
  const GroupCall({
    required this.provider,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return ChangeNotifierProvider.value(
      value: provider,
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          color: ColorConstant.kGroupBlackColor,
          padding: Constants.kPagePadding,
          child: Column(
            children: [
              Text(
                "Active Players",
                style: Styles.bigWhiteHeading
              ),
              Spacer(),
              PlayersCallListWidget(),
              PlayersCallListWidget(),
              Spacer(flex: 2,),
              Text(
                "Group Call",
                style: Styles.bigWhiteHeading,
              ),

              Constants.kVerySmallBox,
              Text(
                  "03:41",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              Constants.kSmallBox,
              Consumer<GroupChatProvider>(
                builder: (context,provider,child) {
                  return GestureDetector(
                    onTap: (){
                      print("Clicked");
                      provider.callEnded();
                      Navigator.pop(context);
                    },
                    child: ClipOval(
                      child: Container(
                        height: 50,
                        width: 50,
                        color: Colors.red,
                        child: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }
              ),
              Constants.kMediumBox,
            ],
          ),
        ),
      ),
    );
  }

  static void openGroupCallPage(BuildContext context,GroupChatProvider provider){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context)=>GroupCall(provider: provider,))
    );
  }
}
