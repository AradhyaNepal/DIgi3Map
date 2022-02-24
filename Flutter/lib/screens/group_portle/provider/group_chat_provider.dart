import 'package:flutter/cupertino.dart';

class GroupChatProvider with ChangeNotifier{
  bool _callIsOn=false;
  bool get callIsOn=>_callIsOn;

  void callStarted(){
    _callIsOn=true;
    notifyListeners();
  }

  void callEnded(){
    _callIsOn=false;
    notifyListeners();
  }
}