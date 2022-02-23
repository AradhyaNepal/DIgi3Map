import 'package:flutter/cupertino.dart';

class PinValueProvider extends ChangeNotifier{
  String correctValue;
  PinValueProvider({required this.correctValue});

  final List<String> _valueList=["","","","","",""];
  void updateList(int index,String value){
    _valueList[index]=value;
    notifyListeners();
  }

  bool get allValueEntered{
    bool enable=true;
    for(String value in _valueList){
      if(value=="") return false;
    }
    return enable;
  }

  bool get isCorrectValueToContinue{
    if(_valueList.join()==correctValue) return true;
    return false;
  }
  String get buttonValue{
    if(allValueEntered){
      if(isCorrectValueToContinue) return "Continue";
      return "Wrong Pin";
    }else{
      return "Enter Pin";
    }

  }
  String get value{
    String returnValue="";
    for(String value in _valueList){
      returnValue+=value;
    }
    return returnValue;
  }

}