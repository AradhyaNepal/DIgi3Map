import 'dart:convert';
import 'dart:io';


import 'package:digi3map/common/classes/HttpException.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/domain_crud/provider/domain_provider.dart';
import 'package:digi3map/screens/domain_list_graph/provider/domain_graph_provider.dart';
import 'package:digi3map/screens/homepage/provides/random_sql.dart';
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
  factory RandomTaskModal.fromMap(Map<dynamic,dynamic> map){
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
  bool isFirst=true;
  RandomProvider(){
    getRandomTask();
  }
  Future<void> getRandomTask() async{
    final sharedPref=await SharedPreferences.getInstance();
    String token =sharedPref.getString(Service.tokenPrefKey)??"";
    Uri uri=Uri.parse(Service.baseApi+Service.randomTaskApi);

    try{
      if(isFirst){
        await saveTransactionFromLocalToServer().onError((error, stackTrace) => print("There was ereor\n $error\n$stackTrace"));
        isFirst=false;

      }
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
      await saveToDatabase();
    }on SocketException{
      randomList.clear();
      await fetchFromDatabase();
    }
    catch (e){
      rethrow;
    }

    isLoading=false;
    notifyListeners();


  }



  Future<void> fetchFromDatabase() async{
    RandomDatabase database=RandomDatabase();
    await database.initialize();
    List<Map> databaseRandomList=await database.getRandomTaskModal();
    for (Map map in databaseRandomList){
      randomList.add(RandomTaskModal.fromMap(map));
    }
  }
  Future<void> saveToDatabase() async{
    RandomDatabase database=RandomDatabase();
    await database.initialize();
    await database.deleteAllRows();
    for (RandomTaskModal random in randomList){
      await database.insertIntoRandom(random);
    }
  }

  Future<void> deleteRandomTask(int id,{bool reFetch=true}) async{
    final sharedPref=await SharedPreferences.getInstance();
    String token =sharedPref.getString(Service.tokenPrefKey)??"";
   try{

     Uri uri=Uri.parse(Service.baseApi+Service.randomTaskApi+"$id/");
     print(uri.toString());
     http.Response response=await http.delete(
         uri,
         headers: {
           "Authorization":"Token $token"
         }
     );
     final responseData=json.decode(response.body);
     if(response.statusCode>299) throw HttpException(message: responseData.toString());
   } on SocketException{
     if(reFetch){
       RandomDatabase database=RandomDatabase();
       print("I was here save 1");
       await database.initialize();
       print("I was here save 2");
       await database.saveTransactionLocally(id);

     }

   }
     if(reFetch)await getRandomTask();

  }

  Future<void> saveTransactionFromLocalToServer() async{
    try{
      await DomainProvider().getFitnessCareerPoints();//TO check network
      print("I was here");
      RandomDatabase database =RandomDatabase();
      await database.initialize();
      List<Map> list=await database.getTransaction();
      print(list);
      for(Map map in list){
        try{
          print("ID TO DELETE: "+map[RandomTaskModal.nameJson].toString());
          await deleteRandomTask(map[RandomTaskModal.nameJson],reFetch: false);
          await database.deleteLocalTransaction(map[RandomTaskModal.idJson],);
        }on SocketException{

        }
        catch(e,s){
          await database.deleteLocalTransaction(map[RandomTaskModal.idJson],);
          print(e);
          print(s);
        }
        print("I was here to deelte the transaction id");
      }
    }on SocketException{

      print("error by network");
    }

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


