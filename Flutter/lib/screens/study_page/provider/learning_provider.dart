import 'dart:convert';
import 'package:digi3map/common/classes/HttpException.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LearningModel {
  int id;
  String heading;
  int totalMinutes;
  String image;

  LearningModel({
    required this.id,
    required this.heading,
    required this.totalMinutes,
    required this.image,
  });
}

class LearningProvider with ChangeNotifier {
  bool isLoading = true;

  LearningProvider() {
    getTodayLearning();
  }

  final List<LearningModel> _learningList = [
    LearningModel(
        id: 1, heading: "Morning Learning", totalMinutes: 30, image: AssetsLocation.morningStudyImageLocation),
    LearningModel(
        id: 2, heading: "Evening Learning", totalMinutes: 30, image: AssetsLocation.eveningStudyImageLocation),
    LearningModel(
        id: 3, heading: "Night Learning", totalMinutes: 30, image: AssetsLocation.nightStudyImageLocation),
  ];

  List<LearningModel> get learningList => _learningList;

  Future<void> addLearningPoints({bool skipped = false}) async {
    final sharedPref = await SharedPreferences.getInstance();
    String token = sharedPref.getString(Service.tokenPrefKey) ?? "";
    Uri uri = Uri.parse(Service.baseApi +
        Service.updateLearningPointsApi +
        "${skipped ? 0 : 1}/");
    http.Response response =
        await http.get(uri, headers: {"Authorization": "Token $token"});
    final responseData = json.decode(response.body);
    if (response.statusCode > 299)
      throw HttpException(message: responseData.toString());
  }

  Future<void> getTodayLearning() async {
    Uri uri = Uri.parse(Service.baseApi + Service.getExcludedLearningApi);
    final sharedPrefs = await SharedPreferences.getInstance();
    String token = sharedPrefs.getString(Service.tokenPrefKey) ?? "";
    http.Response response =
        await http.get(uri, headers: {"Authorization": "Token $token"});
    final responseData = json.decode(response.body);
    if (response.statusCode > 299)
      throw HttpException(message: responseData.toString());
    for (Map<String, dynamic> map in responseData) {
      try {
        _learningList.removeWhere((element) => element.id == map["study_id"]);
      } catch (e) {
        print("Errror learning provider try catch: ${e.toString()}");
      }
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> addTransaction(int studyId) async {
    DateTime today = DateTime.now();
    String dateSlug =
        "${today.year.toString()}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
    print(dateSlug);
    Uri uri = Uri.parse(Service.baseApi + Service.addLearningTransactionApi);
    final sharedPref = await SharedPreferences.getInstance();
    int userId = sharedPref.getInt(Service.userId) ?? 0;
    http.Response response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "study_id": studyId,
          "completed_date": dateSlug,
          "user_id": userId
        }));
    if (response.statusCode > 299)
      throw HttpException(message: json.decode(response.body).toString());
    getTodayLearning();
  }
}
