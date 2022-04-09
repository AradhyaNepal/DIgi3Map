import 'dart:convert';
import 'package:digi3map/common/classes/HttpException.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/habits/provider/habits_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HabitTaskProvider with ChangeNotifier{
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
    int domainPoints=0;
    currentHabitsList.clear();
    int highCount=0;
    int lowCount=0;
    int mediumCount=0;
    int highExtraPoints=0;
    int lowExtraPoints=0;
    int mediumExtraPoints=0;
    for (Map<String,dynamic> map in userHabitsData){
      Habit habit=Habit.fromMap(map: map);
      currentHabitsList.add(habit);
      domainPoints+=habit.points??0;
      if(habit.domainPriority=="High"){
        highCount++;
      }else if(habit.domainPriority=="Medium"){
        mediumCount++;
      }
      else{
        lowCount++;
      }
    }
    for (Map<String,dynamic> map in excludedHabitsData){
      currentHabitsList.removeWhere((element) => element.id==map['habitId']);
    }

    currentHabitsList.sort((a,b)=>(a.points??0).compareTo(b.points??0));

    final List<Habit> highPriorityList=currentHabitsList.where((element) => element.domainPriority=="High").toList();
    //highPriorityList.sort((a,b)=>(a.points??0).compareTo(b.points??0));
    List<Habit> mediumPriorityList=currentHabitsList.where((element) => element.domainPriority=="Medium").toList();
    //mediumPriorityList.sort((a,b)=>a.points??0.compareTo(b.points??0));
    List<Habit> lowPriorityList=currentHabitsList.where((element) => element.domainPriority=="Low").toList();
    //lowPriorityList.sort((a,b)=>a.points??0.compareTo(b.points??0));

    print("\n\n\n");
    currentHabitsList.clear();
    currentHabitsList.addAll(highPriorityList);
    currentHabitsList.addAll(mediumPriorityList);
    currentHabitsList.addAll(lowPriorityList);

    for(Habit habit in currentHabitsList){
      print(habit.domainName+" "+habit.points.toString());
    }
    isLoading=false;
    notifyListeners();

  }



  Future<void> addTransaction({required int habitId,bool failed=false}) async{
    Uri uri=Uri.parse(Service.baseApi+Service.addHabitTransaction+"${failed?0:1}/");
    final sharedPref=await SharedPreferences.getInstance();
    String token =sharedPref.getString(Service.tokenPrefKey)??"";
    int userId=sharedPref.getInt(Service.userId)??0;
    DateTime today = DateTime.now();
    String dateSlug ="${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}";
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
    if(!failed){
      uri=Uri.parse(Service.baseApi+Service.addDomainHabitPoints+"$habitId/");
      response=await http.get(
        uri,
        headers: {
          "Authorization":"Token $token"
        }
      );
      final pointsResponse=json.decode(response.body);
      if(response.statusCode>299) throw HttpException(message: pointsResponse.toString());

      uri=Uri.parse(Service.baseApi+Service.addChainJson);
      print("Date $dateSlug");
      response=await http.post(
        uri,
        body: json.encode({
          "collected_date":dateSlug,
          "habit_id":habitId
        }),
        headers: {
          "Content-Type":"application/json"
        }
      );
      final milestoneResponse=json.decode(response.body);
      if(response.statusCode>299) throw HttpException(message: milestoneResponse.toString());
    }
    await getHabitsList();
  }
}