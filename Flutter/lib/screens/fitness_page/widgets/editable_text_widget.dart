
import 'package:digi3map/theme/colors.dart';
import 'package:flutter/material.dart';

class EditableTextWidget extends StatefulWidget {
  const EditableTextWidget({
    Key? key,
    required this.defaultValue,
    required this.unit,
  }) : super(key: key);

  final String defaultValue;
  final String unit;

  @override
  State<EditableTextWidget> createState() => _EditableTextWidgetState();
}

class _EditableTextWidgetState extends State<EditableTextWidget> {
  bool forEdit=false;
  String value="";
  final TextEditingController controller=TextEditingController();
  @override
  void dispose() {

    controller.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    value=widget.defaultValue;
    controller.text=value;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: forEdit?
          TextField(
            keyboardType: TextInputType.number,
            controller: controller,
          ):
          Text(
              value
          ),
        ),
        Flexible(
            child: IconButton(
              onPressed: (){
                if(forEdit){
                  value=controller.text;
                }else{
                  controller.text=value;
                }
                setState(() {
                  forEdit=!forEdit;
                });
              },
              icon: Icon(
                forEdit?Icons.save_alt_outlined:Icons.edit,
                color: ColorConstant.kIconColor,
              ),
            )
        )
      ],
    );
  }
}
