import 'package:digi3map/screens/group_portle/provider/group_chat_provider.dart';
import 'package:digi3map/screens/group_portle/widget/basic_effect.dart';
import 'package:digi3map/screens/group_portle/widget/group_chat_top_view.dart';
import 'package:digi3map/screens/group_portle/widget/join_call_widget.dart';
import 'package:digi3map/screens/group_portle/widget/send_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupChat extends StatefulWidget {

  GroupChat({Key? key}) : super(key: key);

  @override
  State<GroupChat> createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  List<BasicEffect> chatMessage=[];

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
                  child: ListView.builder(
                      reverse: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: chatMessage.length,
                      itemBuilder: (context,index){
                        return chatMessage[index];
                    }
                  ),
                ),
                Consumer<GroupChatProvider>(
                    builder: (context,provider,child){
                      return provider.callIsOn?JoinCallWidget():SizedBox();
                    }
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:0,horizontal: 10),
                  child: SendMessageWidget(
                      controller: _controller,
                      addToList: addToList
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addToList(){
    FocusScope.of(context).unfocus();
    chatMessage=[
      BasicEffect(message: _controller.text, sender: "Aradhya Nepal", time: "18:30",leftAlign: false,),
      BasicEffect(message: _controller.text, sender: "Aradhya Nepal", time: "18:30",leftAlign: true,),
      ...chatMessage,
    ];
    _controller.text="";
    setState(() {

    });
  }
}
