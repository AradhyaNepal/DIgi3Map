
import 'package:digi3map/theme/colors.dart';
import 'package:flutter/material.dart';

class SendMessageWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function addToList;
  const SendMessageWidget({
    required this.controller,
    required this.addToList,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 65),

      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                onSubmitted: (value){
                  addToList();
                },
                maxLines: 100,
                maxLength: 254,
                decoration: InputDecoration(
                    hintText: "Type Your Message Here....",
                    counterText: "",
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none

                ),
                controller: controller,
              )
          ),
          IconButton(
              onPressed: (){
                addToList();
              },
              icon: Icon(
                Icons.send,
                color: ColorConstant.kBlueColor,
              )
          )
        ],
      ),
    );
  }
}
