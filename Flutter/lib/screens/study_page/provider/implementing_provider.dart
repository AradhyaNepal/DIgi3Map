import 'dart:convert';
import 'package:digi3map/common/classes/HttpException.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ImplementingModel{
  int id;
  String name,image;
  int numberOfSets;
  int restMinutes;
  int setsMinutes;
  ImplementingModel({
    required this.id,
    required this.image,
    required this.name,
    required this.numberOfSets,
    required this.restMinutes,
    required this.setsMinutes,
  });
}


class ImplementingProvider with ChangeNotifier{
  bool isLoading=true;
  ImplementingProvider(){
    getTodayImplementing();
  }
  final List<ImplementingModel> _implementingList=[
    ImplementingModel(
        id: 1,
        image: AssetsLocation.morningStudyImageLocation,
        name: "Morning Practice",
        numberOfSets: 2,
        restMinutes: 2,
        setsMinutes: 20
    ),
    ImplementingModel(
        id: 2,
        image: AssetsLocation.eveningStudyImageLocation,
        name: "Evening Work",
        numberOfSets: 5,
        restMinutes: 5,
        setsMinutes: 30
    ),
    ImplementingModel(
        id: 3,
        image: AssetsLocation.nightStudyImageLocation,
        name: "Night Practice",
        numberOfSets: 2,
        restMinutes: 2,
        setsMinutes: 20
    ),
  ];

  List<ImplementingModel> get implementingList=>_implementingList;

  Future<void> addImplementingPoints({bool skipped=false}) async{
    final sharedPref=await SharedPreferences.getInstance();
    String token =sharedPref.getString(Service.tokenPrefKey)??"";
    Uri uri=Uri.parse(Service.baseApi+Service.updateImplementingPointsApi+"${skipped?0:1}/");
    http.Response response=await http.get(
        uri,
        headers: {
          "Authorization":"Token $token"
        }
    );
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(message: responseData.toString());
  }


  Future<void> getTodayImplementing() async{
    Uri uri=Uri.parse(Service.baseApi+Service.getExcludedImplementingApi);
    final sharedPrefs=await SharedPreferences.getInstance();
    String token=sharedPrefs.getString(Service.tokenPrefKey)??"";
    http.Response response=await http.get(
        uri,
        headers: {
          "Authorization":"Token $token"
        }
    );
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(message: responseData.toString());
    for (Map<String,dynamic> map in responseData){
      try{
        _implementingList.removeWhere((element) => element.id==map["implement_id"]);

      }catch(e){
        print("Errror implementing provider try catch: ${e.toString()}");
      }
    }
    isLoading=false;
    notifyListeners();
  }

  Future<void> addTransaction(int implementingId) async{
    DateTime today = DateTime.now();
    String dateSlug ="${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}";
    print(dateSlug);
    Uri uri=Uri.parse(Service.baseApi+Service.addImplementingTransactionApi);
    final sharedPref=await SharedPreferences.getInstance();
    int userId=sharedPref.getInt(Service.userId)??0;
    http.Response response=await http.post(
        uri,
        headers: {
          "Content-Type":"application/json"
        },
        body: json.encode(
            {
              "implement_id":implementingId,
              "completed_date":dateSlug,
              "user_id":userId
            }
        )
    );
    if(response.statusCode>299) throw HttpException(message: json.decode(response.body).toString());
    getTodayImplementing();
  }
}