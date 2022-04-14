import 'dart:convert';
import 'dart:io';

import 'package:digi3map/common/classes/HttpException.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/domain_crud/provider/domain_provider.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/provider/milestone_provider.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/widgets/milestone_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
class Habit{
  static const idJson="id",nameJson="name",photoJson="photo_url",todoName="Todo",timerName="Timer",setsAndRepsName="Sets & Reps",
  widgetJson="widget_type",descriptionJson="description",progressJson="progress",domainJson="domain_id",setsJson="sets",restJson="rest",timeJson="time";
  //static const List<String> widgetList=[todoName,timerName,setsAndRepsName];
  late String name,domainId,photoUrl,widgetType,description;

  dynamic id,progress;

  int? points;
  String? domainPriority;
  int? sets,rest,time;
  late String domainName;
  Habit({
    this.id,
    this.sets,
    this.rest,
    this.time,
    this.domainPriority,
    required this.domainName,
    required this.name,
    required this.domainId,
    required this.photoUrl,
    required this.widgetType,
    required this.description,
    required this.progress,
  });

  Habit.fromDatabase({
    required Map<dynamic,dynamic> map,
  }){
    id=map[idJson];
    name=map[nameJson];

    photoUrl=map[photoJson];
    widgetType=map[widgetJson];
    description=map[descriptionJson];
    progress=map[progressJson];
    time=map[timeJson];
    sets=map[setsJson];
    rest=map[restJson];


    domainName="";
    domainPriority="";
    points=0;

    domainId="0";
  }
  Habit.fromMap({
    required Map<dynamic,dynamic> map,
  }){
    id=map[idJson];
    name=map[nameJson];
    domainId=(map[domainJson]["id"]).toString();
    photoUrl=map[photoJson];
    widgetType=map[widgetJson];
    description=map[descriptionJson];
    progress=map[progressJson];
    time=map[timeJson];
    sets=map[setsJson];
    rest=map[restJson];
    domainName=map[domainJson]["name"];
    domainPriority=map[domainJson]["priority"];
    points=map[domainJson]["points"];
  }

  MileStone getMilestone({bool showNavigator=true}){
    return MileStone(
        habitId: id,
        heading: name, subheading: MileStoneProvider()
        .getSubheading(widgetType, name), coins: MileStoneProvider()
        .getCoin(widgetType), imageUrl: photoUrl, progress: progress,showNavigator:showNavigator );
  }
}

typedef DomainCalculator=String Function(String value);
class HabitsProvider with ChangeNotifier{
  HabitsProvider(){
    getDomain();
  }
  DomainCalculator idCalculator=(String value){return "";};
  bool isDomainLoading=true;
  bool addingAllowed=false;
  List<String> domainList=[];
  Future<void> getDomain() async{
    isDomainLoading=true;
    notifyListeners();
    List<Domain> totalDomains=await DomainProvider().getDomainList();
    addingAllowed=totalDomains.length<3;
    List<Domain> totalAvailableDomain=await DomainProvider().getDomainList(forHabit: true);
    domainList= totalAvailableDomain.map((e) => e.domainName).toList();
    await getIdCalculator();
    isDomainLoading=false;
    notifyListeners();


  }
  Future<void> getIdCalculator() async{
    List<Domain> totalAvailableDomain=await DomainProvider().getDomainList(forHabit: false);
    idCalculator=(String domainName){
      String index= totalAvailableDomain.firstWhere((element) => domainName==element.domainName).domainId.toString();

      return index;
    };
  }


  Future<void> deleteFunction(String id) async{
    Uri uri=Uri.parse(Service.baseApi+Service.habitLocation+"$id/");
    http.Response response=await http.delete(uri);
    try{

      if(response.statusCode>299) throw HttpException(message: "Error Deleting");

    }catch(e){

    }
  }

  static Future<Habit> getHabit({required int id}) async{
    Uri uri=Uri.parse(Service.baseApi+Service.habitLocation+"$id/");
    http.Response response=await http.get(uri);
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(message: responseData);
    Habit habit= Habit.fromMap(map: responseData);
    habit.domainName=await DomainProvider.getDomainName(id: habit.domainId);
    return habit;
  }
  Future<void> addUpdateHabit(Habit habit,{bool haveNewImage=true}) async{
    bool add=habit.id==null;
    String editingId=add?"":"${habit.id}/";
    Uri uri = Uri.parse(Service.baseApi+Service.habitLocation+editingId);
    String purpose=add?"POST":"PATCH";

    var request = http.MultipartRequest(purpose, uri);
    if(haveNewImage){
      File file=File(habit.photoUrl);
      List<int> byteData=List.from(await file.readAsBytes());
      String imageName=habit.photoUrl.split("/").last;
      var multipartFileSign =  http.MultipartFile.fromBytes(Habit.photoJson,byteData,filename: imageName,
          contentType: MediaType('multipart', 'form-data',{"charset": Service.encryptionValue}));
      request.files.add(multipartFileSign);
    }

    request.fields[Habit.nameJson] = habit.name;
    request.fields[Habit.domainJson] = habit.domainId;
    request.fields[Habit.widgetJson] = habit.widgetType;
    request.fields[Habit.descriptionJson] = habit.description;
    print(habit.time.runtimeType);
    print(habit.time);
    if(habit.rest!=null)request.fields[Habit.restJson] = habit.rest.toString();
    if(habit.time!=null)request.fields[Habit.timeJson] = habit.time.toString();
    if(habit.sets!=null)request.fields[Habit.setsJson] = habit.sets.toString();

    print(request.fields);
    await request.send().then((streamValue) {
      http.Response.fromStream(streamValue).then((response) {
        final responseData = json.decode(utf8.decode(response.bodyBytes));
        if (response.statusCode > 299) throw HttpException(message:responseData.toString());

      });
    });



  }
}