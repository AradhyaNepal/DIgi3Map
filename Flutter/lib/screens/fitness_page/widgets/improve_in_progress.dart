
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class ImproveInProgressWidget extends StatefulWidget {
  const ImproveInProgressWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ImproveInProgressWidget> createState() => _ImproveInProgressWidgetState();
}

class _ImproveInProgressWidgetState extends State<ImproveInProgressWidget> {
  bool value=true;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            "Progress if you improve more",
            style: Styles.opacityHeadingStyle,
          ),
        ),
        SizedBox(width: 10,),
        Switch(
            value: value,
            onChanged: (value){
              this.value=value;
              setState(() {

              });
            }
        )
      ],
    );
  }
}
