import 'package:flutter/material.dart';

class CustomSnackBar{
  static showSnackBar(BuildContext context,String message){
    final messenger=ScaffoldMessenger.of(context);
    messenger.removeCurrentSnackBar();
    messenger.showSnackBar(SnackBar(content:Text(message)));

  }
}