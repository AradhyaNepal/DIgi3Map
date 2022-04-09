import 'dart:convert';
import 'dart:io';


import 'package:digi3map/common/classes/HttpException.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
class RandomTaskModal{

  static const String idJson="id",nameJson="name",imageJson="image",
  priorityJson="priority",taskTypeJson="taskType",taskMinuteJson="taskMinute",
  setsJson="sets",restMinuteJson="restMinute",descriptionJson="description",userIdJson="user_id";

  static const List<String> randomTaskPriorityList=['High','Medium','Low'];
  static const List<String> widgetTypeList=['Todo','Timer','Sets & Task','Sets & Timer'];
  String name,imagePath,priority,type;
  String? description;
  int? time,sets,rest,id;
  RandomTaskModal({
    required this.name,
    required this.imagePath,
    required this.priority,
    required this.type,
    this.description,
    this.id,
    this.time,
    this.sets,
    this.rest,
  });
  factory RandomTaskModal.fromMap(Map<String,dynamic> map){
    return RandomTaskModal(
        name: map[nameJson],
        imagePath: map[imageJson],
        priority: map[priorityJson],
        type: map[taskTypeJson],
        description: map[descriptionJson],
        id: map[idJson],
        sets:map[setsJson],
        time: map[taskMinuteJson],
        rest: map[restMinuteJson]

    );
  }
}
class RandomProvider with ChangeNotifier{
  final List<RandomTaskModal> randomList=[];
  bool isLoading=true;
  RandomProvider(){
    getRandomTask();
  }
  Future<void> getRandomTask() async{
    final sharedPref=await SharedPreferences.getInstance();
    String token =sharedPref.getString(Service.tokenPrefKey)??"";
    Uri uri=Uri.parse(Service.baseApi+Service.randomTaskApi);
    http.Response response=await http.get(
      uri,
      headers: {
        "Authorization":"Token $token"
      }
    );
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(message: responseData.toString());
    randomList.clear();
    for(Map<String,dynamic> map in responseData){
      randomList.add(RandomTaskModal.fromMap(map));
    }
    List<RandomTaskModal> highPriority=randomList.where((element) => element.priority==RandomTaskModal.randomTaskPriorityList[0]).toList();
    List<RandomTaskModal> mediumPriority=randomList.where((element) => element.priority==RandomTaskModal.randomTaskPriorityList[1]).toList();
    List<RandomTaskModal> lowPriority=randomList.where((element) => element.priority==RandomTaskModal.randomTaskPriorityList[2]).toList();
    randomList.clear();
    randomList.addAll(highPriority);
    randomList.addAll(mediumPriority);
    randomList.addAll(lowPriority);
    isLoading=false;
    notifyListeners();


  }

  Future<void> deleteRandomTask(int id) async{
   Uri uri=Uri.parse(Service.baseApi+Service.randomTaskApi+"$id/");
   final sharedPref=await SharedPreferences.getInstance();
   String token =sharedPref.getString(Service.tokenPrefKey)??"";
   http.Response response=await http.delete(
     uri,
     headers: {
       "Authorization":"Token $token"
     }
   );
   final responseData=json.decode(response.body);
   if(response.statusCode>299) throw HttpException(message: responseData.toString());
   await getRandomTask();
  }
  Future<void> addUpdateRandomTask(RandomTaskModal randomTask,{bool haveNewImage=true}) async{
    bool add=randomTask.id==null;
    String editingId=add?"":"${randomTask.id}/";
    Uri uri = Uri.parse(Service.baseApi+Service.randomTaskLocation+editingId);
    String purpose=add?"POST":"PATCH";
    var request = http.MultipartRequest(purpose, uri);

    if(haveNewImage){
      File file=File(randomTask.imagePath);
      List<int> byteData=List.from(await file.readAsBytes());
      String imageName=randomTask.imagePath.split("/").last;
      var multipartFileSign =  http.MultipartFile.fromBytes(RandomTaskModal.imageJson
          ,byteData,filename: imageName,
          contentType: MediaType('multipart', 'form-data',{"charset": Service.encryptionValue}));
      request.files.add(multipartFileSign);
    }
    final sharedPref=await SharedPreferences.getInstance();
    int userId=sharedPref.getInt(Service.userId)??0;
    String token=sharedPref.getString(Service.tokenPrefKey)??"";
    request.headers.addAll({
      "Authorization":"Token $token"
    });
    request.fields[RandomTaskModal.nameJson] = randomTask.name;
    request.fields[RandomTaskModal.priorityJson] = randomTask.priority;
    request.fields[RandomTaskModal.taskTypeJson] = randomTask.type;
    request.fields[RandomTaskModal.userIdJson] = userId.toString();
    if(randomTask.time!=null)request.fields[RandomTaskModal.taskMinuteJson] = randomTask.time.toString();
    if(randomTask.sets!=null)request.fields[RandomTaskModal.setsJson] = randomTask.sets.toString();
    if(randomTask.rest!=null)request.fields[RandomTaskModal.restMinuteJson] = randomTask.rest.toString();
    if(randomTask.description!=null)request.fields[RandomTaskModal.descriptionJson] = randomTask.description.toString();
    final responseStream=await request.send();
    final response=await http.Response.fromStream(responseStream);
    final responseData = json.decode(utf8.decode(response.bodyBytes));
    if(response.statusCode>299) throw HttpException(message: responseData.toString());
    await getRandomTask();



  }
}


