import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:digi3map/data/services/services_names.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Domain{
  static const domainIdJson="id",percentageJson="percentage",userIdJson="user_id",imagePathJson="photo_url",habitNameJson="name",domainNameJson="name",descriptionJson="description",priorityJson="priority";
  late String imagePath,domainName,description,priority;
  late int userId;
  int? percentage;
  int? domainId;
  Domain({
    required this.imagePath,
    required this.domainName,
    required this.description,
    required this.userId,
    this.domainId,
    required this.priority
  });

  Domain.fromMap(Map<String,dynamic> map){
    imagePath=map[imagePathJson];
    domainName=map[domainNameJson];
    description=map[descriptionJson];
    priority=map[priorityJson];
    userId=map[userIdJson];
    domainId=map[domainIdJson];
    percentage=map[percentageJson];
  }

}


class DomainProvider with ChangeNotifier{
  final List<Domain> _domainList=[];
  bool _domainLoading=true;
  bool get domainLoading=>_domainLoading;
  List<Domain> get domainList=>_domainList;
  Future<void> getDomainList() async{
    _domainLoading=true;
    notifyListeners();
    final sharedPrefs=await SharedPreferences.getInstance();
    Uri uri=Uri.parse(Service.baseApi+Service.userDomains+"${sharedPrefs.getInt(Service.userId)}/");
    print(uri.toString());
    http.Response response=await http.get(
      uri,
    );
    List<dynamic> responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(responseData.toString());
    _domainList.clear();
    for(int i=0;i<responseData.length;i++){
      _domainList.add(Domain.fromMap(responseData[i]));
    }
    _domainLoading=false;
    notifyListeners();
  }

  Future<List<String>> getDomainHabitsList(int domainId) async{
    Uri uri=Uri.parse(Service.baseApi+Service.domainHabits+"$domainId/");
    List<String> habitsNameList=[];
    http.Response response=await http.get(uri);
    List<dynamic> habitsList=json.decode(response.body);
    for(Map<String,dynamic> habit in habitsList){
      habitsNameList.add(habit[Domain.habitNameJson]);
    }
    return habitsNameList;

  }

  Future<void> deleteDomain(String domainId) async{
    Uri uri=Uri.parse(Service.baseApi+Service.domains+"$domainId/");
    http.Response response=await http.delete(uri);
    if (response.statusCode > 299) throw HttpException(json.decode(response.body).toString());
    getDomainList();

  }
  Future<void> addEditDomain(Domain domain,{bool haveNewImage=true}) async{
    bool add=domain.domainId==null;
    String editingId=add?"":"${domain.domainId}/";
    Uri uri=Uri.parse(Service.baseApi+Service.domains+editingId);
    String purpose=add?"POST":"PATCH";
    var request = http.MultipartRequest(purpose, uri);
    if(haveNewImage){
      File file=File(domain.imagePath);
      List<int> byteData=List.from(await file.readAsBytes());
      String imageName=domain.imagePath.split("/").last;
      var multipartFileSign =  http.MultipartFile.fromBytes(Domain.imagePathJson,byteData,filename: imageName,
          contentType: MediaType('multipart', 'form-data',{"charset": Service.encryptionValue}));
      request.files.add(multipartFileSign);
    }
    request.fields[Domain.userIdJson] = domain.userId.toString();
    request.fields[Domain.domainNameJson] = domain.domainName;
    request.fields[Domain.descriptionJson] = domain.description;
    request.fields[Domain.priorityJson] = domain.priority;
    await request.send().then((streamValue) {
      http.Response.fromStream(streamValue).then((response) {
        final responseData = json.decode(utf8.decode(response.bodyBytes));
        if (response.statusCode > 299) throw HttpException(responseData.toString());
        getDomainList();
      });
    });


  }
}