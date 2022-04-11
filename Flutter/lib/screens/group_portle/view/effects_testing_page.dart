import 'package:digi3map/common/constants.dart';
import 'package:digi3map/screens/group_portle/provider/group_chat_provider.dart';
import 'package:digi3map/screens/group_portle/widget/basic_effect.dart';
import 'package:digi3map/screens/group_portle/widget/death_effect.dart';
import 'package:digi3map/screens/group_portle/widget/hope_effect.dart';
import 'package:digi3map/screens/group_portle/widget/lighting_effect.dart';
import 'package:digi3map/screens/group_portle/widget/passion_effect.dart';
import 'package:digi3map/screens/group_portle/widget/send_message_testing_widget.dart';
import 'package:digi3map/screens/group_portle/widget/send_message_widget.dart';
import 'package:digi3map/screens/group_portle/widget/vengeance_effect.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum EffectType{
  death,
  sanity,
  vengeance,
  passion,
  hope
}
class EffectTestingPage extends StatefulWidget {
  final EffectType effectType;

  const EffectTestingPage({
    required this.effectType,
    Key? key
  }) : super(key: key);

  @override
  State<EffectTestingPage> createState() => _EffectTestingPageState();
}

class _EffectTestingPageState extends State<EffectTestingPage> {
  List<Widget> _messageWidget=[];
  final TextEditingController _controller=TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _controller.text="\t";
      addInToList();
    });
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context)=>GroupChatProvider(),
      child: SafeArea(
          child: Scaffold(
            body: Container(
              padding: Constants.kPagePaddingNoDown,
              height: size.height,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                      "Effect Chat Testing",
                    style: Styles.bigHeading,
                  ),
                  Constants.kSmallBox,
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _messageWidget.length,
                      itemBuilder: (context,index){
                        return _messageWidget[index];
                      },
                    ),
                  ),
                  SendMessageTestingWidget(
                    addToList: addInToList,
                    controller: _controller,
                  )

                ],
              ),
            ),
          )
      ),
    );
  }

  void addInToList(){
    ChatModel chatModel=ChatModel(forTesting:true,username: "Aradhya", message: "", image: null, chatEffect: 1, userId: -1, effectTime: "");
    FocusScope.of(context).unfocus();
    Widget? effectWidgetLeft;
    Widget? effectWidgetRight;
    switch(widget.effectType){
      case EffectType.death:
        effectWidgetLeft=DeathEffect(
          chatModal: chatModel,
          key: ValueKey(_controller.text),
          message: _controller.text,
          sender: "Aradhya Nepal",
          time: "11:30",
          leftAlign: true,

        );
        effectWidgetRight=DeathEffect(
          chatModal: chatModel,
          key: ValueKey(_controller.text),
          message: _controller.text,
          sender: "Aradhya Nepal",
          time: "11:30",
          leftAlign: false,
        );
        break;
      case EffectType.sanity:
        effectWidgetLeft=LightingEffect(
          chatModel: chatModel,
          key: ValueKey(_controller.text),
          message: _controller.text,
          sender: "Aradhya Nepal",
          time: "11:30",
          leftAlign: true,
        );
        effectWidgetRight=LightingEffect(
          chatModel: chatModel,
          key: ValueKey(_controller.text),
          message: _controller.text,
          sender: "Aradhya Nepal",
          time: "11:30",
          leftAlign: false,
        );
        break;
      case EffectType.vengeance:
        effectWidgetLeft=VengeanceEffect(
          chatModel: chatModel,
          key: ValueKey(_controller.text),
          message: _controller.text,
          sender: "Aradhya Nepal",
          time: "11:30",
          leftAlign: true,
        );
        effectWidgetRight=VengeanceEffect(
          chatModel: chatModel,
          key: ValueKey(_controller.text),
          message: _controller.text,
          sender: "Aradhya Nepal",
          time: "11:30",
          leftAlign: false,
        );
        break;
      case EffectType.passion:
        effectWidgetLeft=PassionEffect(
          chatModel: chatModel,
          key: ValueKey(_controller.text),
          message: _controller.text,
          sender: "Aradhya Nepal",
          time: "11:30",
          leftAlign: true,
        );
        effectWidgetRight=PassionEffect(
          chatModel: chatModel,
          key: ValueKey(_controller.text),
          message: _controller.text,
          sender: "Aradhya Nepal",
          time: "11:30",
          leftAlign: false,
        );
        break;
      case EffectType.hope:
        effectWidgetLeft=HopeEffect(
          chatModel: chatModel,
          key: ValueKey(_controller.text),
          message: _controller.text,
          sender: "Aradhya Nepal",
          time: "11:30",
          leftAlign: true,
        );
        effectWidgetRight=HopeEffect(
          chatModel: chatModel,
          key: ValueKey(_controller.text),
          message: _controller.text,
          sender: "Aradhya Nepal",
          time: "11:30",
          leftAlign: false,
        );
        break;

    }
    _messageWidget=[
      effectWidgetRight,
      BasicEffect(chatModal:chatModel,message: _controller.text, sender: "Aradhya Nepal", time: "11:30",leftAlign: true,),
      BasicEffect(chatModal:chatModel,message: _controller.text, sender: "Aradhya Nepal", time:"11:30",leftAlign: false),
      effectWidgetLeft,
      ..._messageWidget,
    ];
    _controller.text="";
    setState(() {

    });
  }
}
