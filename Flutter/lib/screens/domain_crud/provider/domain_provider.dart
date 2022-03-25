import 'dart:convert';
import 'dart:io';
import 'package:digi3map/common/classes/HttpException.dart';
import 'package:digi3map/screens/domain_list_graph/provider/domain_graph_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:digi3map/data/services/services_names.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Domain{
  static const domainIdJson="id",pointsJson="points",userIdJson="user_id",imagePathJson="photo_url",habitNameJson="name",domainNameJson="name",descriptionJson="description",priorityJson="priority";
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
    percentage=map[pointsJson];
  }

}

class Points{
  int fitnessPoint,careerPoints;
  Points({
    required this.fitnessPoint,
    required this.careerPoints
  });
}
class DomainProvider with ChangeNotifier{
  final List<Domain> _domainList=[];
  bool _domainLoading=true;
  bool get domainLoading=>_domainLoading;
  List<Domain> get domainList=>_domainList;
  Points points=Points(fitnessPoint: 0,careerPoints: 0);

  static Future<String> getDomainName({required String id}) async{
    Uri uri=Uri.parse(Service.baseApi+Service.domains+"$id/");
    http.Response response=await http.get(uri);
    if(response.statusCode>299) throw HttpException(message: json.decode(response.body).toString());
    final responseData=json.decode(response.body);
    return responseData[Domain.domainNameJson];
  }
  Future<List<Domain>> getDomainList({bool forHabit=false}) async{
    _domainLoading=true;
    notifyListeners();
    final sharedPrefs=await SharedPreferences.getInstance();
    DomainGraphModel pointsValue= await DomainGraphProvider().getDomainGraph();
    points=Points(fitnessPoint: pointsValue.yAxis[0], careerPoints: pointsValue.yAxis[1]);
    String middleUrl=forHabit?Service.userAvailableDomains:Service.userDomains;
    Uri uri=Uri.parse(Service.baseApi+middleUrl+"${sharedPrefs.getInt(Service.userId)}/");

    http.Response response=await http.get(
      uri,
    );
    List<dynamic> responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(message:responseData.toString());
    _domainList.clear();
    for(int i=0;i<responseData.length;i++){
      _domainList.add(Domain.fromMap(responseData[i]));
    }
    _domainLoading=false;
    notifyListeners();
    return _domainList;
  }

  static const String fitnessPointsJson="finess_points",careerPointsJson="carrer_points";
  Future<Points> getPoints() async{
    final sharedPrefs=await SharedPreferences.getInstance();
    int userId=sharedPrefs.getInt(Service.userId)??0;
    Uri uri=Uri.parse(Service.baseApi+Service.userJson+"$userId/");
    print(uri.toString());
    http.Response response=await http.get(uri);
    if(response.statusCode>299) throw HttpException(message: json.decode(response.body).toString());
    final responseData=json.decode(response.body);
    return Points(fitnessPoint: responseData[fitnessPointsJson], careerPoints: responseData[careerPointsJson]);

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
    if (response.statusCode > 299) throw HttpException(message:json.decode(response.body).toString());
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
        if (response.statusCode > 299) throw HttpException(message:responseData.toString());
        getDomainList();
      });
    });


  }
}