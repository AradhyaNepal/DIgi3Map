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
    milestoneList.add(MileStone(habitId:0,heading: "Workout", subheading: getSubheading(Habit.setsAndRepsName, "Workout"), coins: getCoin(Habit.setsAndRepsName), imageUrl: AssetsLocation.workoutImageLocation, progress: responseData[workoutProgressJson],compulsoryHabit: true));
    milestoneList.add(MileStone(habitId:0,heading: "Diet", subheading: getSubheading(Habit.todoName, "Follow Diet"), coins: getCoin(Habit.todoName), imageUrl: AssetsLocation.snacksImageLocation, progress: responseData[dietProgressJson],compulsoryHabit: true));
    milestoneList.add(MileStone(habitId:0,heading: "Learn Theory", subheading: getSubheading(Habit.timerName, "Learn Theory"), coins: getCoin(Habit.timerName), imageUrl: AssetsLocation.studyDummyLocation, progress: responseData[learningProgressJson],compulsoryHabit: true));
    milestoneList.add(MileStone(habitId:0,heading: "Implement Practically", subheading: getSubheading(Habit.setsAndRepsName, "Implement Practically"), coins: getCoin(Habit.setsAndRepsName), imageUrl: AssetsLocation.anonymousImageLocation, progress: responseData[implementingProgressJson],compulsoryHabit: true));
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