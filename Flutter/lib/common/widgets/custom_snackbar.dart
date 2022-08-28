import 'package:digi3map/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomSnackBar{
  static showSnackBar(BuildContext context,String message){
    final messenger=ScaffoldMessenger.of(context);
    messenger.removeCurrentSnackBar();
    messenger.showSnackBar(
        SnackBar(
            backgroundColor:ColorConstant.kBlueColor,
            content:Text(message)
        )
    );

  }
}