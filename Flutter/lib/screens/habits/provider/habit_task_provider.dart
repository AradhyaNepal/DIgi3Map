import 'dart:convert';
import 'dart:io';
import 'package:digi3map/common/classes/HttpException.dart';
import 'package:digi3map/common/classes/database.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/domain_crud/provider/domain_provider.dart';
import 'package:digi3map/screens/habits/provider/habit_database.dart';
import 'package:digi3map/screens/habits/provider/habits_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

class HabitTaskProvider with ChangeNotifier{
  bool first=true;
  List<Habit> currentHabitsList=[];
  bool isLoading=true;
  HabitTaskProvider(){
    getHabitsList();
  }

  Future<void> getHabitsList() async{
    final sharedPref=await SharedPreferences.getInstance();
    String token= sharedPref.getString(Service.tokenPrefKey)??"";
    int userId=sharedPref.getInt(Service.userId)??0;
    Uri userHabits=Uri.parse(Service.baseApi+Service.userHabits+"$userId/");
    try{
      if(first){
        await sendLocalTransactionToServer();
        first=false;
      }
      http.Response response=await http.get(
          userHabits,
          headers: {
            "Authorization":"Token $token"
          }
      );
      final userHabitsData=json.decode(response.body);
      Uri excludedHabits=Uri.parse(Service.baseApi+Service.excludedHabit);
      if(response.statusCode>299) throw HttpException(message: userHabitsData.toString());
      response=await http.get(
          excludedHabits,
          headers: {
            "Authorization":"Token $token"
          }
      );
      final excludedHabitsData=json.decode(response.body);
      if(response.statusCode>299) throw HttpException(message: excludedHabitsData.toString());
      currentHabitsList.clear();
      for (Map<String,dynamic> map in userHabitsData){
        Habit habit=Habit.fromMap(map: map);
        currentHabitsList.add(habit);
      }
      for (Map<String,dynamic> map in excludedHabitsData){
        currentHabitsList.removeWhere((element) => element.id==map['habitId']);
      }
      if(currentHabitsList.length>1){
        //If length is less than one then it does not make any sense to do sorting
        for (int index=0;index<currentHabitsList.length;index++) {
          Habit current=currentHabitsList[index];
          if(current.domainPriority=="High"){
            current.points=((current.points??0)-(current.points??0)*0.4).toInt();
          }
          else if(current.domainPriority=="Medium"){
            current.points=((current.points??0)-(current.points??0)*0.2).toInt();
          }
          currentHabitsList[index]=current;
        }
        currentHabitsList.sort((a,b)=>(a.points??0).compareTo(b.points??0));
      }
      await HabitDatabase.deleteAllRows();
      for (Habit habit in currentHabitsList){
        await HabitDatabase.insertIntoHabit(habit);
      }
    }on SocketException{
      currentHabitsList.clear();
      for(Map map in await HabitDatabase.getHabit()){
        currentHabitsList.add(Habit.fromDatabase(map: map));
      }

    }

    isLoading=false;
    notifyListeners();
  }

  Future<void> sendLocalTransactionToServer() async{
    try{
      await DomainProvider().getFitnessCareerPoints();//TO check network
      print("I was here");

      List<Map> list=await HabitDatabase.getTransaction();
      print(list);
      for(Map map in list){
        try{
          print("ID TO DELETE: "+map[Habit.nameJson].toString());
          await addTransaction(habitId:map[Habit.nameJson],failed:map[habitFailed]==1,reFetch: false,date: map[collectedDate]);
          await HabitDatabase.deleteLocalTransaction(map[Habit.idJson],);
        }on SocketException{

        }
        catch(e,s){
          await HabitDatabase.deleteLocalTransaction(map[Habit.idJson],);
          print(e);
          print(s);
        }
        print("I was here to deelte the transaction id");
      }
    }on SocketException{

      print("error by network");
    }
  }

  Future<void> addTransaction({required int habitId,bool failed=false,String? date,bool reFetch=true}) async{
    Uri uri=Uri.parse(Service.baseApi+Service.addHabitTransaction+"${failed?0:1}/");
    final sharedPref=await SharedPreferences.getInstance();
    String token =sharedPref.getString(Service.tokenPrefKey)??"";
    int userId=sharedPref.getInt(Service.userId)??0;

    DateTime today = DateTime.now();
    String dateSlug =date??"${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}";
    try{
      http.Response response=await http.post(
          uri,
          headers: {
            "Authorization":"Token $token",
            "Content-Type":"application/json"
          },
          body: json.encode({
            "completed_date":dateSlug,
            "habitId":habitId,
            "userId":userId
          })
      );
      final transactionResponse=json.decode(response.body);
      if(response.statusCode>299) throw HttpException(message: transactionResponse.toString());
      if(!failed) {
        uri = Uri.parse(
            Service.baseApi + Service.addDomainHabitPoints + "$habitId/");
        response = await http.get(
            uri,
            headers: {
              "Authorization": "Token $token"
            }
        );
        final pointsResponse = json.decode(response.body);
        if (response.statusCode > 299) throw HttpException(
            message: pointsResponse.toString());

        uri = Uri.parse(Service.baseApi + Service.addChainJson);
        print("Date $dateSlug");
        response = await http.post(
            uri,
            body: json.encode({
              "collected_date": dateSlug,
              "habit_id": habitId
            }),
            headers: {
              "Content-Type": "application/json"
            }
        );
        final milestoneResponse = json.decode(response.body);
        if (response.statusCode > 299) throw HttpException(
            message: milestoneResponse.toString());
      }
    }on SocketException{
      print(" I was here 123");
      if(reFetch)await HabitDatabase.saveTransactionLocally(habitId, failed, dateSlug);
      print(" I was here 456");
    }
    if(reFetch)await getHabitsList();
  }
}