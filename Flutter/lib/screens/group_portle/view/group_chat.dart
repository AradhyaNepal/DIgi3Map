import 'package:digi3map/common/constants.dart';
import 'package:digi3map/screens/group_portle/widget/send_message_widget.dart';
import 'package:flutter/material.dart';

class GroupChat extends StatelessWidget {
  final TextEditingController _controller=TextEditingController();
  GroupChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          padding: Constants.kPagePaddingNoDown,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GroupChatTopView(),
              Expanded(
                child: ListView.builder(
                    itemBuilder: (context,index){
                      return SizedBox();
                    }
                ),
              ),
              SendMessageWidget(
                  controller: _controller,
                  addToList: addToList
              )
            ],
          ),
        ),
      ),
    );
  }

  void addToList(){}
}

class GroupChatTopView extends StatelessWidget {
  const GroupChatTopView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
