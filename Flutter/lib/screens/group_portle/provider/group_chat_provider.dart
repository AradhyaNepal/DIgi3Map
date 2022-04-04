import 'dart:convert';

import 'package:digi3map/common/classes/HttpException.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GroupChatProvider with ChangeNotifier{
  GroupChatProvider(){
    initializeGroupChat();
  }
  bool isLoading=true;
  late final int leaderboardId;
  late final int userId;
  final List<ChatModel> chatList=[];
  late final int effectId;
  Future<void> initializeGroupChat() async{
    final sharedPref=await SharedPreferences.getInstance();
    leaderboardId=sharedPref.getInt(Service.leaderboardPrefKey)??0;
    userId=sharedPref.getInt(Service.userId)??0;
    effectId=sharedPref.getInt(Service.activatedEffectId)??0;
    await getMessage();
    isLoading=false;
    notifyListeners();
  }
  bool _callIsOn=false;
  bool get callIsOn=>_callIsOn;

  void callStarted(){
    _callIsOn=true;
    notifyListeners();
  }

  void callEnded(){
    _callIsOn=false;
    notifyListeners();
  }

  Future<void> getMessage() async{
    Uri uri=Uri.parse(Service.baseApi+Service.getMessageJson+"$leaderboardId/");
    http.Response response=await http.get(
      uri
    );
    final responseData=json.decode(response.body);
    chatList.clear();
    for(Map<String,dynamic> map in responseData){
      chatList.add(
          ChatModel.fromMap(map)
      );
    }
    notifyListeners();

  }
  Future<void> sendMessage(String message) async{
    Uri uri=Uri.parse(Service.baseApi+Service.sendMessageJson);
    final dateTime=DateTime.now().toString();
    String time=dateTime;
    print(dateTime);

    http.Response response=await http.post(
      uri,
      headers: {
        "Content-Type":"application/json"
      },
      body: json.encode({
        "message":message,
        "time":time,
        "leaderboard_id":leaderboardId,
        "user_id": userId,
        "chat_effect":effectId==0?null:effectId
        })
    );
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(message: responseData.toString());
    getMessage();

  }
}


class ChatModel{
  String message;
  int? chatEffect;
  int userId;
  String? image;
  String effectTime;
  String username;
  ChatModel({
    required this.username,
    required this.message,
    required this.image,
    required this.chatEffect,
    required this.userId,
    required this.effectTime
  });

  factory ChatModel.fromMap(Map<String,dynamic> chatMap){
    return ChatModel(
      image: chatMap["user_id"]['userImage'],
        message: chatMap["message"],
        chatEffect: chatMap["chat_effect"],
        userId: chatMap["user_id"]["id"],
        username: chatMap["user_id"]["username"].toString().substring(0,1).toUpperCase()+chatMap["user_id"]["username"].toString().substring(1).toLowerCase(),
        effectTime: (chatMap["time"] as String).substring(11,16)
    );
  }
}