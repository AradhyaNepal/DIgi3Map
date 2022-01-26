import 'package:digi3map/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  int value;
  CustomLinearProgressIndicator(this.value);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 3,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: ColorConstant.kBlueColor,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Center(
                  child: Text(
                      "Loading...",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
            for(int i=1;i<=value;i++) Text("⚡"),
            Spacer(flex: 1,)
          ],
        ),
      ),
    );
  }
}
