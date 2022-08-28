import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/group_portle/provider/group_chat_provider.dart';
import 'package:digi3map/screens/group_portle/widget/user_popup_testing.dart';
import 'package:digi3map/screens/user_profile/widgets/anonymous_widget.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasicEffect extends StatelessWidget {
  final String message;
  final String sender;
  final String time;
  final bool leftAlign;
  final ChatModel chatModal;
  final normalRadius=const Radius.circular(10);
  final spikeRadius=const Radius.circular(2);
  final imageSize=50.0;

  const BasicEffect({
    required this.message,
    required this.sender,
    required this.time,
    required this.chatModal,
    this.leftAlign=true,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment:leftAlign?CrossAxisAlignment.start:CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment:leftAlign?MainAxisAlignment.start:MainAxisAlignment.end,
            children: [
              SizedBox(width: leftAlign?30:0,),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: leftAlign?ColorConstant.kMessageLeft:ColorConstant.kMessageRight,
                    borderRadius: BorderRadius.only(
                      topRight: normalRadius,
                      topLeft: normalRadius,
                      bottomRight: leftAlign?normalRadius:spikeRadius,
                      bottomLeft: leftAlign?spikeRadius:normalRadius,
                    )
                  ),
                  child: Column(
                    crossAxisAlignment:leftAlign?CrossAxisAlignment.start:CrossAxisAlignment.end,
                    children: [
                      Text(
                          message,

                        key:ValueKey(message),
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      Text(
                        time,

                        key:ValueKey(time),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                          fontSize: 8,
                          color: Colors.white
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: leftAlign?0:30,),
            ],
          ),
          UserImageInChat(leftAlign: leftAlign, chatModal: chatModal,big: false,)

        ],
      ),
    );
  }
}

class UserImageInChat extends StatelessWidget {
  final bool big;
  const UserImageInChat({
    Key? key,
    this.big=true,
    required this.leftAlign,
    required this.chatModal,
  }) : super(key: key);

  final bool leftAlign;
  final ChatModel chatModal;

  @override
  Widget build(BuildContext context) {

    return Consumer<GroupChatProvider>(
      builder: (context,provider,child) {
        return GestureDetector(
          onTap: (){
            if(!chatModal.forTesting){
              showDialog(

                  context: context,
                  builder: (_){
                    return ChangeNotifierProvider.value(
                      value: provider,
                      child: leftAlign?NormalGroupWidget(
                        chatModel: chatModal,
                      ):AnonyGroupWidget(

                        chatModel: chatModal,
                      ),
                    );
                  }
              );
            }

          },
          child: big?
          Align(
            alignment: leftAlign?Alignment.centerLeft:Alignment.centerRight,
            child: ClipOval(
              child: !chatModal.forTesting?
              Image.network(
                Service.baseApiNoDash+chatModal.image!,
                height:50,
                width: 50,
                fit: BoxFit.cover,
              ): Image.asset(
                AssetsLocation.userDummyProfileLocation,
                height: 50,
                width: 50,
              ),
            ),
          ):

          ClipOval(
            child: !chatModal.forTesting?
            Image.network(
              Service.baseApiNoDash+(chatModal.image??""),
              height: 30,
              width: 30,

              fit: BoxFit.cover,
            ):
            Image.asset(
              AssetsLocation.userDummyProfileLocation,
              height: 30,
              width: 30,
            ),
          ),
        );
      }
    );
  }
}