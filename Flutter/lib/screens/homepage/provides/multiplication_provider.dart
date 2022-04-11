import 'package:flutter/cupertino.dart';

class MultiplicationProvider with ChangeNotifier{
  MultiplicationProvider(){
    getOnePercent();
  }
  bool isLoading=true;
  static const List<String> energyFilterList=[
    'Depressed😭',
    'Stressed😵',
    'Void😐',
    'Happy 😊',
    'Mania😂 '
  ];
  static const List<double> energyMultiplication=[
    0.5,
    0.75,
    1,
    1.25,
    1.5
  ];
  int _selectedEnergyIndex=2;
  int get selectedEnergyIndex=>_selectedEnergyIndex;
  String get defaultValue=>energyFilterList[_selectedEnergyIndex];
  double get multiplication{
    return energyMultiplication[_selectedEnergyIndex];
  }

  Future<void> getOnePercent() async{
    isLoading=false;
    notifyListeners();
  }

  void updateIndex(int index){
    _selectedEnergyIndex=index;
    notifyListeners();
  }
}