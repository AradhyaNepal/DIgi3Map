
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class AnonymousWidget extends StatefulWidget {

  const AnonymousWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AnonymousWidget> createState() => _AnonymousWidgetState();
}

class _AnonymousWidgetState extends State<AnonymousWidget> {
  bool enabled=false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Anonymous Mode",
          style: Styles.blueHighlight,
        ),
        Constants.kVerySmallBox,
        Switch(
            value: enabled,
            onChanged: (value){
              setState(() {
                enabled=value;
              });
            }
        )
      ],
    );
  }
}
