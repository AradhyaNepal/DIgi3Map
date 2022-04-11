import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/screens/group_portle/provider/group_chat_provider.dart';
import 'package:digi3map/screens/group_portle/widget/basic_effect.dart';
import 'package:digi3map/screens/group_portle/widget/death_effect.dart';
import 'package:digi3map/screens/group_portle/widget/group_chat_top_view.dart';
import 'package:digi3map/screens/group_portle/widget/hope_effect.dart';
import 'package:digi3map/screens/group_portle/widget/join_call_widget.dart';
import 'package:digi3map/screens/group_portle/widget/lighting_effect.dart';
import 'package:digi3map/screens/group_portle/widget/passion_effect.dart';
import 'package:digi3map/screens/group_portle/widget/send_message_widget.dart';
import 'package:digi3map/screens/group_portle/widget/vengeance_effect.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupChat extends StatefulWidget {

  GroupChat({Key? key}) : super(key: key);

  @override
  State<GroupChat> createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {


  final TextEditingController _controller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: ChangeNotifierProvider(
            create: (context)=>GroupChatProvider(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GroupChatTopView(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:Constants.kPaddingValue/2),
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        Expanded(
                          child: Consumer<GroupChatProvider>(
                            builder: (context,provider,child) {
                              return provider.isLoading?
                              const Center(
                                child: CustomCircularIndicator(),
                              ):
                              ListView.builder(
                                  reverse: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: provider.chatList.length,
                                  itemBuilder: (context,index){
                                    return getEffect(provider.chatList[index],!(provider.userId==provider.chatList[index].userId));
                                  }
                              );
                            }
                          ),
                        ),
                        Consumer<GroupChatProvider>(
                            builder: (context,provider,child){
                              return provider.callIsOn?JoinCallWidget():SizedBox();
                            }
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical:0,horizontal: 10),
                  child: SendMessageWidget(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getEffect(ChatModel chatModel,bool leftAlign){

    switch(chatModel.chatEffect){
      case 1:
        return DeathEffect(
          chatModal:chatModel,
            message: chatModel.message, sender: chatModel.username, time: chatModel.effectTime,leftAlign: leftAlign,
        );
      case 2:
        return LightingEffect(
            chatModel:chatModel,
            message: chatModel.message, sender: chatModel.username, time: chatModel.effectTime,leftAlign: leftAlign
        );
      case 3:
        return VengeanceEffect(
            chatModel:chatModel,
            message: chatModel.message, sender: chatModel.username, time: chatModel.effectTime,leftAlign: leftAlign
        );
      case 4:
        return PassionEffect(
            chatModel:chatModel,
            message: chatModel.message, sender: chatModel.username, time: chatModel.effectTime,leftAlign: leftAlign
        );
      case 5:
        return HopeEffect(
            chatModel:chatModel,
            message: chatModel.message, sender: chatModel.username, time:chatModel.effectTime,leftAlign: leftAlign
        );

      default:
        return BasicEffect(
            message: chatModel.message,
            sender: chatModel.username,
            time:chatModel.effectTime,
            leftAlign: leftAlign,
          chatModal:chatModel,
        );
    }
  }

}
