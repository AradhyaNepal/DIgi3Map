
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/screens/group_portle/provider/group_chat_provider.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendMessageWidget extends StatefulWidget {

  SendMessageWidget({
    Key? key
  }) : super(key: key);

  @override
  State<SendMessageWidget> createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  bool isSending=false;
  final TextEditingController controller=TextEditingController();

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
              child: Consumer<GroupChatProvider>(
                builder: (context,provider,child) {
                  return TextField(
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value){
                      setState(() {
                        isSending=true;
                      });
                      provider.sendMessage(controller.text).then((value){
                        controller.text="";

                        isSending=false;

                        FocusScope.of(context).unfocus();
                        setState(() {

                        });
                      }).onError((error, stackTrace) {
                        CustomSnackBar.showSnackBar(context, error.toString());
                        isSending=false;
                        setState(() {

                        });
                      });


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
                  );
                }
              )
          ),
          Consumer<GroupChatProvider>(
            builder: (context,provider,child) {
              return isSending?CustomCircularIndicator():IconButton(
                  onPressed: (){
                    setState(() {
                      isSending=true;
                    });
                    provider.sendMessage(controller.text).then((value){
                      controller.text="";

                      isSending=false;
                      FocusScope.of(context).unfocus();
                      setState(() {

                      });
                    }).onError((error, stackTrace) {
                      CustomSnackBar.showSnackBar(context, error.toString());
                      isSending=false;
                      setState(() {

                      });
                    });
                  },
                  icon: Icon(
                    Icons.send,
                    color: ColorConstant.kBlueColor,
                  )
              );
            }
          )
        ],
      ),
    );
  }


}
