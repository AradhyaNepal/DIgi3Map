import 'dart:convert';
import 'package:digi3map/common/classes/HttpException.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/fitness_page/widgets/fitness_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RandomProvider with ChangeNotifier{
  bool isLoading=true;
  RandomProvider(){
    getTodayFitness();
  }
  final List<FitnessModel> _fitnessList=[
    FitnessModel(id:1,name: "BenchPress",  image: AssetsLocation.benchPressImageLocation, musclesTargeted: ["Chest","Triceps"], weightAndRep: "20 Kg With 8 Reps", setsCount: 5, restMinute: 1),
    FitnessModel(id:2,name: "Machine Pull Down",  image: AssetsLocation.pullDownImageLocation, musclesTargeted: ["Back","Bicep"], weightAndRep: "45 Kg With 8 Reps",setsCount: 5, restMinute: 2),
    FitnessModel(id:3,name: "Shoulder Press",  image: AssetsLocation.shoulderPressImageLocation, musclesTargeted: ["Shoulder","Triceps"], weightAndRep: "10 Kg With 8 Reps",setsCount: 5, restMinute: 1),
    FitnessModel(id:4,name: "Squat",  image:AssetsLocation.squadImageLocation, musclesTargeted: ["Hams","Core"], weightAndRep: "40 Kg With 7 Reps",setsCount: 5, restMinute: 3),
    FitnessModel(id:5,name: "Deadlift",  image: AssetsLocation.deadLiftImageLocation, musclesTargeted: ["Quads","Glutes","Back","Core"], weightAndRep: "55 Kg With 6 Reps",setsCount: 5, restMinute: 4),

  ];

  List<FitnessModel> get fitnessList=>_fitnessList;

  Future<void> addFitnessPoints({bool skipped=false}) async{
    final sharedPref=await SharedPreferences.getInstance();
    String token =sharedPref.getString(Service.tokenPrefKey)??"";
    Uri uri=Uri.parse(Service.baseApi+Service.updateWorkoutPointsApi+"${skipped?0:1}/");
    http.Response response=await http.get(
        uri,
      headers: {
          "Authorization":"Token $token"
      }
    );
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(message: responseData.toString());
  }
  Future<void> getTodayFitness() async{
    Uri uri=Uri.parse(Service.baseApi+Service.getExcludedFitnessApi);
    final sharedPrefs=await SharedPreferences.getInstance();
    String token=sharedPrefs.getString(Service.tokenPrefKey)??"";
    print(uri.toString());
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
        _fitnessList.removeWhere((element) => element.id==map["fitness_id"]);

      }catch(e){
        print("Errror fitness provider try catch: ${e.toString()}");
      }
    }
    isLoading=false;
    notifyListeners();


  }

  Future<void> addTransaction(int fitnessId) async{
    DateTime today = DateTime.now();
    String dateSlug ="${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}";
    print(dateSlug);
    Uri uri=Uri.parse(Service.baseApi+Service.addFitnessTransactionApi);
    final sharedPref=await SharedPreferences.getInstance();
    int userId=sharedPref.getInt(Service.userId)??0;
    http.Response response=await http.post(
      uri,
      headers: {
        "Content-Type":"application/json"
      },
      body: json.encode(
          {
            "fitness_id":fitnessId,
            "completed_date":dateSlug,
            "user_id":userId
          }
      )
    );
    if(response.statusCode>299) throw HttpException(message: json.decode(response.body).toString());
    getTodayFitness();
  }
}