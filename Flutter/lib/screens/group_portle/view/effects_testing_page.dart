import 'package:digi3map/common/constants.dart';
import 'package:digi3map/screens/group_portle/widget/basic_effect.dart';
import 'package:digi3map/screens/group_portle/widget/death_effect.dart';
import 'package:digi3map/screens/group_portle/widget/hope_effect.dart';
import 'package:digi3map/screens/group_portle/widget/lighting_effect.dart';
import 'package:digi3map/screens/group_portle/widget/passion_effect.dart';
import 'package:digi3map/screens/group_portle/widget/send_message_widget.dart';
import 'package:digi3map/screens/group_portle/widget/vengeance_effect.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

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
      _controller.text="";
      addInToList();
    });
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
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
                SendMessageWidget(
                  addToList: addInToList,
                  controller: _controller,
                )

              ],
            ),
          ),
        )
    );
  }

  void addInToList(){
    Widget? effectWidgetLeft;
    Widget? effectWidgetRight;
    switch(widget.effectType){
      case EffectType.death:
        effectWidgetLeft=DeathEffect(
          key: ValueKey(_controller.text),
          message: _controller.text,
          sender: "Aradhya Nepal",
          time: DateTime.now().toIso8601String(),
          leftAlign: true,
        );
        effectWidgetRight=DeathEffect(

          key: ValueKey(_controller.text),
          message: _controller.text,
          sender: "Aradhya Nepal",
          time: DateTime.now().toIso8601String(),
          leftAlign: false,
        );
        break;
      case EffectType.sanity:
        effectWidgetLeft=LightingEffect(

          key: ValueKey(_controller.text),
          message: _controller.text,
          sender: "Aradhya Nepal",
          time: DateTime.now().toIso8601String(),
          leftAlign: true,
        );
        effectWidgetRight=LightingEffect(

          key: ValueKey(_controller.text),
          message: _controller.text,
          sender: "Aradhya Nepal",
          time: DateTime.now().toIso8601String(),
          leftAlign: false,
        );
        break;
      case EffectType.vengeance:
        effectWidgetLeft=VengeanceEffect(

          key: ValueKey(_controller.text),
          message: _controller.text,
          sender: "Aradhya Nepal",
          time: DateTime.now().toIso8601String(),
          leftAlign: true,
        );
        effectWidgetRight=VengeanceEffect(

          key: ValueKey(_controller.text),
          message: _controller.text,
          sender: "Aradhya Nepal",
          time: DateTime.now().toIso8601String(),
          leftAlign: false,
        );
        break;
      case EffectType.passion:
        effectWidgetLeft=PassionEffect(

          key: ValueKey(_controller.text),
          message: _controller.text,
          sender: "Aradhya Nepal",
          time: DateTime.now().toIso8601String(),
          leftAlign: true,
        );
        effectWidgetRight=PassionEffect(

          key: ValueKey(_controller.text),
          message: _controller.text,
          sender: "Aradhya Nepal",
          time: DateTime.now().toIso8601String(),
          leftAlign: false,
        );
        break;
      case EffectType.hope:
        effectWidgetLeft=HopeEffect(
          key: ValueKey(_controller.text),
          message: _controller.text,
          sender: "Aradhya Nepal",
          time: DateTime.now().toIso8601String(),
          leftAlign: true,
        );
        effectWidgetRight=HopeEffect(
          key: ValueKey(_controller.text),
          message: _controller.text,
          sender: "Aradhya Nepal",
          time: DateTime.now().toIso8601String(),
          leftAlign: false,
        );
        break;

    }
    _messageWidget=[
      effectWidgetRight,
      BasicEffect(message: _controller.text, sender: "Aradhya Nepal", time: "",leftAlign: true,),
      BasicEffect(message: _controller.text, sender: "Aradhya Nepal", time: "",leftAlign: false),
      effectWidgetLeft,
      ..._messageWidget,
    ];
    _controller.text="";
    setState(() {

    });
  }
}
