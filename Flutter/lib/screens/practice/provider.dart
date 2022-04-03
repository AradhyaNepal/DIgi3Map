import 'package:flutter/cupertino.dart';

class PracticeProvider extends ChangeNotifier{

  PracticeProvider(){
    getJsonRequest();
  }
  bool isExtracting=true;
  String serverValue="";
  void getJsonRequest(){
    print("Is Extracting called");
    isExtracting=true;
    notifyListeners();
    Future.delayed(Duration(seconds: 2),(){
      isExtracting=false;
      serverValue="Server Value";
      notifyListeners();
    });
  }
}