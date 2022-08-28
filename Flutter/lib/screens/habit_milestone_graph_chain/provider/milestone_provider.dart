import 'dart:convert';

import 'package:digi3map/common/classes/HttpException.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/widgets/milestone_widget.dart';
import 'package:digi3map/screens/habits/provider/habits_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MileStoneProvider with ChangeNotifier{
  List<MileStone> milestoneList=[];
  bool isLoading=true;
  int? points;

  MileStoneProvider(){
    getUserTotalCoins();
  }


  String getSubheading(String type,String heading){
    switch(type){
      case Habit.setsAndRepsName:
        return "$heading For 10 Hour And 15 Sets";
      case Habit.timerName:
        return "$heading For 10 Hour";
      case Habit.todoName:
        return "$heading For 20 Times";
      default:
        return "$heading For 20 Times";
    }
  }
  int getCoin(String type){
    switch(type){
      case Habit.setsAndRepsName:
        return 20;
      case Habit.timerName:
        return 15;
      case Habit.todoName:
        return 10;
      default:
        return 10;
    }
  }
  static const String workoutProgressJson="workout_progress",
      dietProgressJson="diet_progress",
      learningProgressJson="learning_progress",
      implementingProgressJson="implementing_progress";



  static const String totalCoinJsonName="totalcoin";
  Future<void> getUserTotalCoins() async{
    points=null;
    notifyListeners();
    final sharedPreferences=await SharedPreferences.getInstance();
    int userId=sharedPreferences.getInt(Service.userId)??0;
    Uri uri=Uri.parse(Service.baseApi+Service.totalCoin+"$userId/");
    await http.get(uri).then((response){
      final responseData=json.decode(response.body);
      points=responseData[totalCoinJsonName];
      notifyListeners();
    });
  }

  int? userId;
  Future<void> clearHabit(int habitId) async{
    print("Habit Id"+habitId.toString());
    if(habitId>0){
      Uri uri=Uri.parse(Service.baseApi+Service.habitLocation+"$habitId/");
      await http.patch(
          uri,
        body: {
            Habit.progressJson:"0"
        }
      );
    }
    else{
      if(userId==null){
        final sharedPreferences=await SharedPreferences.getInstance();
        userId=sharedPreferences.getInt(Service.userId)??0;
      }
      Uri uri=Uri.parse(Service.baseApi+Service.userProgressJson+"$userId/");
      Map<String,String> map={};
      switch(habitId){
        case workoutEnumId:
          map={
            workoutProgressJson:"0"
          };
          break;
        case dietEnumId:
          map={
            dietProgressJson:"0"
          };
          break;
        case learnEnumId:
          map={
            learningProgressJson:"0"
          };
          break;
        case implementEnumId:
          map={
            implementingProgressJson:"0"
          };
          break;
        default:
          break;

      }
      await http.patch(
        uri,
        body: map
      );
    }

  }
  static const String amountJson="amount",remarkJson="remark",dateCollectedJson="dateCollected",userIdJson="user_id";
  Future<void> collectCoin(int coin) async{
    final sharedPreferences=await SharedPreferences.getInstance();
    int userId=sharedPreferences.getInt(Service.userId)??0;
    const String remark="MileStone Coin";
    String dateCollected=DateTime.now().year.toString()+"-"+DateTime.now().month.toString()+"-"+DateTime.now().day.toString();
    Uri uri=Uri.parse(Service.baseApi+Service.coinJson);
    await http.post(
        uri,
      body:{
        amountJson:coin.toString(),
        remarkJson:remark,
        dateCollectedJson:dateCollected,
        userIdJson:userId.toString()
      }
    ).then((response){
      final responseData=json.decode(response.body);
      if(response.statusCode>299) throw HttpException(message: responseData.toString());
      getUserTotalCoins();
    });
  }

  static const workoutEnumId=0,dietEnumId=-1,learnEnumId=-2,implementEnumId=-3;
  Future<void> getMilestones() async{
    isLoading=true;
    notifyListeners();
    final sharedPreferences=await SharedPreferences.getInstance();
    int userId=sharedPreferences.getInt(Service.userId)??0;
    Uri compulsoryUri= Uri.parse(Service.baseApi+Service.userJson+"$userId/");
    http.Response response=await http.get(compulsoryUri);
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(message: responseData.toString());
    milestoneList.clear();
    milestoneList.add(MileStone(habitId:workoutEnumId,heading: "Workout", subheading: getSubheading(Habit.setsAndRepsName, "Workout"), coins: getCoin(Habit.setsAndRepsName), imageUrl: AssetsLocation.workoutImageLocation, progress: responseData[workoutProgressJson],compulsoryHabit: true));
    milestoneList.add(MileStone(habitId:dietEnumId,heading: "Diet", subheading: getSubheading(Habit.todoName, "Follow Diet"), coins: getCoin(Habit.todoName), imageUrl: AssetsLocation.snacksImageLocation, progress: responseData[dietProgressJson],compulsoryHabit: true));
    milestoneList.add(MileStone(habitId:learnEnumId,heading: "Learn Theory", subheading: getSubheading(Habit.timerName, "Learn Theory"), coins: getCoin(Habit.timerName), imageUrl: AssetsLocation.studyDummyLocation, progress: responseData[learningProgressJson],compulsoryHabit: true));
    milestoneList.add(MileStone(habitId:implementEnumId,heading: "Implement Practically", subheading: getSubheading(Habit.setsAndRepsName, "Implement Practically"), coins: getCoin(Habit.setsAndRepsName), imageUrl: AssetsLocation.anonymousImageLocation, progress: responseData[implementingProgressJson],compulsoryHabit: true));
    Uri optionalUri= Uri.parse(Service.baseApi+Service.userHabits+"$userId/");
    response=await http.get(optionalUri);
    final responseData2=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(message: responseData2.toString());
    for (Map<String,dynamic> habitsMap in responseData2){
      milestoneList.add(Habit.fromMap(map: habitsMap).getMilestone());
    }
    isLoading=false;
    notifyListeners();
  }
}