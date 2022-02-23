
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class FailedSuccessDietWidget extends StatelessWidget {
  const FailedSuccessDietWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: (){},
              child: Text(
                "Failed",
                style: Styles.smallHeading,
              )
          ),
        ),
        Flexible(
          child: ElevatedButton(
              onPressed: (){},
              child: Text(
                "Done",
                style: Styles.smallHeading,
              )
          ),
        ),

      ],
    );
  }
}
