import 'dart:convert';

import 'package:digi3map/common/classes/HttpException.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/domain_crud/provider/domain_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class DomainGraphModel{
  List<String> xAxis;
  List<int> yAxis;
  DomainGraphModel({
    required this.xAxis,
    required this.yAxis
  });
}
class DomainGraphProvider{
  Future<DomainGraphModel> getDomainGraph() async{
    final sharedPrefs=await SharedPreferences.getInstance();
    Uri uri=Uri.parse(Service.baseApi+Service.userDomains+"${sharedPrefs.getInt(Service.userId)}/");
    print(uri.toString());
    return await http.get(uri).then((response) async{
      final responseData=json.decode(response.body);
      if(response.statusCode>299) throw HttpException(message: responseData.toString());
      FitnessCareerPoints points=await DomainProvider().getFitnessCareerPoints();
      List<String> xAxis=["Fitness","Career"];
      List<int> yAxis=[points.fitnessPoint,points.careerPoints];
      for(Map<String,dynamic> domainMap in responseData){
        xAxis.add(domainMap[Domain.habitNameJson]);
        yAxis.add(domainMap[Domain.pointsJson]);

      }
      int totalPoints=0;
      for (int element in yAxis) {
        totalPoints=totalPoints+element;
      }
      List<int> yAxisPercentage=yAxis.map((e) => (((e)/(totalPoints+0.1))*100).toInt()).toList();

      return DomainGraphModel(xAxis: xAxis, yAxis: yAxisPercentage);
    });
  }
}