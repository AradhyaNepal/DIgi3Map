import 'dart:convert';

import 'package:digi3map/common/classes/HttpException.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/group_portle/provider/leaderboard_player.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LeaderboardProvider with ChangeNotifier{

  LeaderboardProvider(){
    getLeaderboard().then((value){
      checkUnCollectedTrophy();
    });
  }
  static const String waitingValue="Waiting";
  static const String detailsKey="details";
  List<int> unCollectedTrophy=[];
  bool _waiting=false;
  bool get waiting=>_waiting;
  final List<LeaderboardPlayers> playersList=[];
  int highestUserId=0;
  bool isLoading=true;
  LeaderboardPlayers? get winnerPlayer{
    try{
      return playersList.firstWhere(
              (element) => element.userId==highestUserId
      );
    }
    catch (e){
      return null;
    }

  }

  List<LeaderboardPlayers> get otherPlayers{
    return playersList.where((element) => element.userId!=highestUserId).toList();
  }

  Future<void> checkUnCollectedTrophy() async{
    final sharedPref=await SharedPreferences.getInstance();
    int userId=sharedPref.getInt(Service.userId)??0;
    Uri uri=Uri.parse(Service.baseApi+Service.uncollectedTrophyApi+"$userId/");
    http.Response response=await http.get(uri);
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(message: responseData.toString());
    unCollectedTrophy=(responseData as List<dynamic>).map((e) => e as int).toList();
    print(unCollectedTrophy);
    notifyListeners();

  }
  Future<void> getLeaderboard() async{
    isLoading=true;
    notifyListeners();
    final sharedPref=await SharedPreferences.getInstance();
    int userId=sharedPref.getInt(Service.userId)??0;
    Uri uri=Uri.parse(Service.baseApi+Service.leaderboardApi+"$userId/");
    print(uri.toString());
    http.Response response=await http.get(uri);
    final responseData=json.decode(response.body);

    try{

      playersList.clear();
      if(responseData[detailsKey]==waitingValue){
        _waiting=true;
      }else{
       getValue(responseData, userId);
      }
    }catch(e){
      getValue(responseData, userId);
    }


    isLoading=false;
    notifyListeners();
  }

  void getValue(dynamic responseData,int userId){
    print("I was here");
    highestUserId=responseData[0][LeaderboardPlayers.userIdJson];
    int highestCoin=0;
    for (Map<String,dynamic> resultMap in responseData){
      playersList.add(LeaderboardPlayers.fromMap(resultMap,resultMap[LeaderboardPlayers.userIdJson]==userId));
      if(resultMap[LeaderboardPlayers.coinJson]>highestCoin){
        highestCoin=resultMap[LeaderboardPlayers.coinJson];
        highestUserId=resultMap[LeaderboardPlayers.userIdJson];
      }
    }
  }

  static Future<void> collectTrophy(List<int> leaderBoardsList) async{
    final sharedPref=await SharedPreferences.getInstance();
    String token=sharedPref.getString(Service.tokenPrefKey)??"";

    for (int id in leaderBoardsList){
      Uri uri=Uri.parse(Service.baseApi+Service.collectUserTrophyApi+"$id/");
      http.Response response=await http.get(
        uri,
        headers: {
          "Authorization":"Token $token"
        }
      );
        final responseData=json.decode(response.body);
        if(response.statusCode>299) throw HttpException(message:responseData.toString());
        print("Error "+responseData.toString());


    }

  }
}
