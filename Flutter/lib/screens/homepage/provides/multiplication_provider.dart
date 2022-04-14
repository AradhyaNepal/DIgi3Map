import 'dart:convert';
import 'dart:io';

import 'package:digi3map/data/services/services_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MultiplicationProvider with ChangeNotifier{
  double onePercentage=1;
  MultiplicationProvider(){
    getOnePercent();
  }
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
    return energyMultiplication[_selectedEnergyIndex]*onePercentage;
  }

  Future<void> getOnePercent() async{
    final sharedPref=await SharedPreferences.getInstance();
    int userId =sharedPref.getInt(Service.userId)??0;
    print("I was serching 1 Percentage");
    try{
      Uri uri =Uri.parse(Service.baseApi+Service.getOnePercentageJson+"$userId/");
      print(uri.toString());
      http.Response response=await http.get(uri,);
      final responseData=json.decode(response.body);
      onePercentage=responseData["details"];
      sharedPref.setDouble(Service.onePercentLocal, onePercentage);
    }on SocketException{
      onePercentage=sharedPref.getDouble(Service.onePercentLocal)??1;
      print(" I was here from offline $onePercentage");
    }catch(e){
      print("Some other error");
    }

    if(onePercentage<0.1) onePercentage=0.1;
    if(onePercentage>2) onePercentage=2;
    notifyListeners();
  }

  void updateIndex(int index){
    _selectedEnergyIndex=index;
    notifyListeners();
  }
}