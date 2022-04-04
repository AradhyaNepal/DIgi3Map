import 'dart:convert';
import 'dart:io';

import 'package:digi3map/common/classes/HttpException.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class UserProfileDetails{
  String username,email;
  int userId;
  String? imageUrl;
  UserProfileDetails({
    required this.username,
    required this.email,
    required this.userId,
    this.imageUrl,
  });

  static const String idJson="id",imageJson="userImage",usernameJson="username",emailJson="email";
  factory UserProfileDetails.fromMap(Map<String,dynamic> map){
    return UserProfileDetails(
        username: map[usernameJson],
        email: map[emailJson],
        userId: map[idJson],
        imageUrl: map[imageJson]
    );

  }
}
class UserProfileProvider with ChangeNotifier{
  UserProfileProvider({bool loadData=true}){
    if(loadData){
      getUserDetails().then((value) {
        getInventory(notify: true);
      });
    }
  }
  UserProfileDetails? details;

  Future<void> getUserDetails() async{
    final sharedPref=await SharedPreferences.getInstance();
    String token = sharedPref.getString(Service.tokenPrefKey)??"";
    Uri uri=Uri.parse(Service.baseApi+Service.userProfileApi);
    http.Response response=await http.get(
      uri,
      headers: {
        "Authorization":"Token $token"
      }
    );
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(message: responseData.toString());
    details=UserProfileDetails.fromMap(responseData);
    notifyListeners();
  }

  Future<void> updateProfilePicture({required String imagePath}) async{
    final sharedPref=await SharedPreferences.getInstance();
    String token =sharedPref.getString(Service.tokenPrefKey)??"";
    Uri uri=Uri.parse(Service.baseApi+Service.updateProfileApi);
    final request = http.MultipartRequest("PATCH", uri);
    request.headers.addAll({
      "Authorization":"Token $token"
    });
    File file=File(imagePath);
    List<int> byteData=List.from(await file.readAsBytes());
    String imageName=imagePath.split("/").last;
    var multipartFileSign =  http.MultipartFile.fromBytes(UserProfileDetails.imageJson,byteData,filename: imageName,
        contentType: MediaType('multipart', 'form-data',{"charset": Service.encryptionValue}));
    request.files.add(multipartFileSign);
    final responseStream=await request.send();
    final response=await http.Response.fromStream(responseStream);
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(message: responseData.toString());
  }


  bool loadingInventory=true;
  List<UserEffectsCount> userEffectCount=[];

  List<UserEffectsCount> getDefault(){
    return [
      UserEffectsCount(effectId: 1, userEffectId: [], count: 0),
      UserEffectsCount(effectId: 2, userEffectId: [], count: 0),
      UserEffectsCount(effectId: 3, userEffectId: [], count: 0),
      UserEffectsCount(effectId: 4, userEffectId: [], count: 0),
      UserEffectsCount(effectId: 5, userEffectId: [], count: 0),
    ];
  }
  Future<void> getInventory({bool notify=false}) async{
    if(notify){
      loadingInventory=true;
      notifyListeners();
    }
    Uri uri=Uri.parse(Service.baseApi+Service.inventoryApi);
    final sharedPrefs=await SharedPreferences.getInstance();
    String token=sharedPrefs.getString(Service.tokenPrefKey)??"";
    http.Response response=await http.get(
        uri,
      headers: {
          "Authorization":"Token $token"
      }
    );
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(message: responseData.toString());
    userEffectCount=getDefault();
    for (Map<String,dynamic> map in responseData){
        int effectIndex=userEffectCount.indexWhere((element) => element.effectId==map["effect_id"]);
        userEffectCount[effectIndex].count++;
        userEffectCount[effectIndex].userEffectId.add(map["id"]);
    }
    loadingInventory=false;
    notifyListeners();
    getActivatedEffect();


  }

  Future<void> activateEffect(int effectId) async{
    int index=userEffectCount.indexWhere((element) =>element.effectId==effectId);
    print(index);
    if(index==-1 || userEffectCount[index].userEffectId.isEmpty){
      throw HttpException(message: "No effect Fount");
    }
    else{
      List<int> userEffectId=userEffectCount[index].userEffectId;
      int deleteIndex=0;

      final sharedPref=await SharedPreferences.getInstance();
      String token=sharedPref.getString(Service.tokenPrefKey)??"";
      Uri uri=Uri.parse(Service.baseApi+Service.activateEffect+"${userEffectId[deleteIndex]}/");
      http.Response response=await http.get(
        uri,
        headers: {
          "Authorization":"Token $token"
        }
      );
      final responseData=json.decode(response.body);
      if(response.statusCode>299) throw HttpException(message: responseData.toString());
      userEffectId.removeAt(deleteIndex);
      userEffectCount[index].userEffectId=userEffectId;
      userEffectCount[index].count--;
      notifyListeners();

    }
  }

  ActivatedEffectModel? activatedEffect;


  Future<void> getActivatedEffect() async{
    print("I was here 123");
    final sharedPref=await SharedPreferences.getInstance();
    String token=sharedPref.getString(Service.tokenPrefKey)??"";
    Uri uri=Uri.parse(Service.baseApi+Service.activatedEffectApi);
    print(uri.toString());

    http.Response response=await http.get(
      uri,
      headers: {
        "Authorization":"Token $token"
      }
    );
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(message: responseData.toString());
    try{
      activatedEffect=ActivatedEffectModel.fromMap(responseData[0]);
      notifyListeners();
      final sharedPref= await SharedPreferences.getInstance();
      sharedPref.setInt(Service.activatedEffectId, responseData[0]["effect_id"]);
      print("I was here for activated effect "+sharedPref.getInt(Service.activatedEffectId).toString());
    // ignore: empty_catches
    }catch(e){
      rethrow;
    }


  }



}


class ActivatedEffectModel{
  int effectId;
  String activatedDate;
  ActivatedEffectModel(
  {
    required this.effectId,
    required this.activatedDate
  });

  factory ActivatedEffectModel.fromMap(Map<String,dynamic> map){
    return ActivatedEffectModel(effectId: map["effect_id"], activatedDate: map["activatedDate"]);
  }
}

class UserEffectsCount{
  int effectId;
  List<int> userEffectId;
  int count;

  UserEffectsCount({
    required this.effectId,
    required this.userEffectId,
    required this.count
  });
}