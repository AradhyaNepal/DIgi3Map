import 'dart:convert';

import 'package:digi3map/common/classes/HttpException.dart';
import 'package:digi3map/data/models/diet_model.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class DietProvider with ChangeNotifier{
  List<Diet> dietData;
  DietProvider(this.dietData){
    getTodayDietList();
  }
  bool isLoading=true;
  Future<void> getTodayDietList() async{
    Uri uri=Uri.parse(Service.baseApi+Service.getExcludedDiet);
    final sharedPref=await SharedPreferences.getInstance();
    String token= sharedPref.getString(Service.tokenPrefKey)??"";
    http.Response response=await http.get(
      uri,
      headers: {
        "Authorization":"Token $token"
      }
    );
    final responseData=json.decode(response.body);

    if(response.statusCode>299) throw HttpException(message: responseData.toString());
    for (Map<String,dynamic> map in responseData){
      dietData.removeWhere((element) => element.id==map["diet_id"].toString());

    }
    isLoading=false;
    notifyListeners();
  }


  Future<void> addDietPoints({bool skipped=false}) async{
    final sharedPref=await SharedPreferences.getInstance();
    String token =sharedPref.getString(Service.tokenPrefKey)??"";
    Uri uri=Uri.parse(Service.baseApi+Service.updateDietPointsApi+"${skipped?0:1}/");
    http.Response response=await http.get(
        uri,
        headers: {
          "Authorization":"Token $token"
        }
    );
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(message: responseData.toString());
  }

  Future<void> addTransaction(String  dietId) async{
    DateTime today = DateTime.now();
    String dateSlug ="${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}";
    print(dateSlug);
    Uri uri=Uri.parse(Service.baseApi+Service.addDietTransactionApi);
    final sharedPref=await SharedPreferences.getInstance();
    int userId=sharedPref.getInt(Service.userId)??0;
    http.Response response=await http.post(
        uri,
        headers: {
          "Content-Type":"application/json"
        },
        body: json.encode(
            {
              "diet_id":dietId,
              "completed_date":dateSlug,
              "user_id":userId
            }
        )
    );
    if(response.statusCode>299) throw HttpException(message: json.decode(response.body).toString());
    getTodayDietList();
  }
}