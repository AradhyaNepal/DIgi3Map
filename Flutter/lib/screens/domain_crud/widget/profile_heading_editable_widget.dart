import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class ProfileHeadingEditableWidget extends StatefulWidget {
  final String value;
  final bool bigHighlight;
  const ProfileHeadingEditableWidget({
    this.value="Dummy",
    this.bigHighlight=false,
    Key? key
  }) : super(key: key);

  @override
  _ProfileHeadingEditableWidgetState createState() => _ProfileHeadingEditableWidgetState();
}

class _ProfileHeadingEditableWidgetState extends State<ProfileHeadingEditableWidget> {
  bool forEditing=false;
  String heading="Dummy";
  final TextEditingController textEditingController=TextEditingController();
  @override
  void initState() {
    super.initState();
    heading=widget.value;
    textEditingController.text=heading;
  }
  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: forEditing?
                TextField(
                  controller: textEditingController,
                  decoration: Styles.getDecorationWithLable("Edit"),
                ):Text(
              heading,
              textAlign: TextAlign.center,
              style: widget.bigHighlight?Styles.bigHeading:Styles.smallHeading,
            ),
          ),
          const SizedBox(width: 10,),
          IconButton(
            onPressed: (){
              if(forEditing){
                if(textEditingController.text.isEmpty){
                  return;
                }
                heading=textEditingController.text;
              }else{
                textEditingController.text=heading;
              }
              forEditing=!forEditing;
              setState((){});
            },
            icon: forEditing?
            const Icon(
              Icons.save_alt_rounded,
              color: ColorConstant.kIconColor,
            ):
            const Icon(
              Icons.edit,
              color: ColorConstant.kIconColor,
            ),
          )
        ],
      ),
    );
  }
}
