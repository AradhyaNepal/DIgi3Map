import 'dart:convert';

import 'package:digi3map/common/classes/HttpException.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class ShopProvider with ChangeNotifier{
  ShopProvider(){
    getTotalTrophy();
  }
  int? totalTrophy;
  static const String countJson="Count";
  Future<void> getTotalTrophy() async{
    totalTrophy=null;
    notifyListeners();
    Uri uri=Uri.parse(Service.baseApi+Service.userTrophyApi);
    final sharedPref=await SharedPreferences.getInstance();
    String token=sharedPref.getString(Service.tokenPrefKey)??"";
    http.Response response=await http.get(
      uri,
      headers: {
        "Authorization":"Token $token"
      }
    );
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(message: responseData.toString());
    totalTrophy=responseData[countJson];
    notifyListeners();
    
  }

  Future<void> buyEffect({required int effectId}) async{
    Uri uri=Uri.parse(Service.baseApi+Service.buyEffectApi+"$effectId/");
    final sharedPref=await SharedPreferences.getInstance();
    String token=sharedPref.getString(Service.tokenPrefKey)??"";
    http.Response response=await http.post(
      uri,
      headers: {
        "Authorization":"Token $token"
      }
    );
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(message: responseData.toString());
    getTotalTrophy();
  }
}