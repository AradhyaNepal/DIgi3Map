import 'dart:async';

import 'package:digi3map/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomLinearProgressIndicator extends StatefulWidget {
  int totalSeconds;
  ValueNotifier<bool> cancelPressed;
  CustomLinearProgressIndicator({
    required this.totalSeconds,
    required this.cancelPressed
  });


  @override
  State<CustomLinearProgressIndicator> createState() => _CustomLinearProgressIndicatorState();
}

class _CustomLinearProgressIndicatorState extends State<CustomLinearProgressIndicator> {

  int value=1;
  late final Timer _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int dividedByTen=(widget.totalSeconds*1000)~/10;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _timer=Timer.periodic(Duration(milliseconds: dividedByTen), (timer) {
        setState(() {
          value+=1;
        });
      });
      Future.delayed(Duration(seconds: widget.totalSeconds),(){
        _timer.cancel();
      });
    });

  }
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder<bool>(
      valueListenable: widget.cancelPressed,
      builder: (context,canclePressed,child) {
        if(canclePressed){
          _timer.cancel();
          return const SizedBox();
        }
        return Card(
          elevation: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: ColorConstant.kBlueColor,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Wrap(
                  children: [
                    for(int i=1;i<=value;i++) const Text("⚡")
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }



}
