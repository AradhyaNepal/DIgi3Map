import 'dart:convert';

import 'package:digi3map/common/classes/HttpException.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier{
  static const String emailKey="email";
  static const String usernameKey="username";
  static const String passwordKey="password";
  static const String tokenKey="token";
  String _token=Service.emptyTokenValue;

  String get token=>_token;
  Future<void> login(String email,String password) async{
    Uri uri=Uri.parse(Service.baseApi+Service.loginApi);
    http.Response response=await http.post(
        uri,
        body: {
          passwordKey:password,
          usernameKey:email
        }
    );

    print(response.body);
    print(response.statusCode);
    if(response.statusCode<300){
      final responseData=json.decode(utf8.decode(response.bodyBytes));
      _token=responseData[tokenKey];
      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      sharedPreferences.setString(Service.tokenPrefKey, _token);
    }
    else{
      throw HttpException(message: json.decode(response.body).toString());
    }
  }

  Future<bool> isLogged() async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    return sharedPreferences.getString(Service.tokenPrefKey)!=Service.emptyTokenValue;
  }

  void logOut() async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.setString(Service.tokenPrefKey, Service.emptyTokenValue);
  }

  Future<void> signUp({
    required String email,required String username,required String password
}) async{
    Uri uri=Uri.parse(Service.baseApi+Service.registerApi);
    http.Response response=await http.post(
        uri,
        body: {
          passwordKey:password,
          usernameKey:username,
          emailKey:email
        }
    );

    print(response.body);
    print(response.statusCode);
    if(response.statusCode<300){
      final responseData=json.decode(utf8.decode(response.bodyBytes));
      _token=responseData[tokenKey];
      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      sharedPreferences.setString(Service.tokenPrefKey, _token);
    }
    else{

      throw HttpException(message: json.decode(response.body).toString());
    }
  }

  static const String oldPasswordKey="old_password";
  static const String newPasswordKey="new_password";
  Future<void> changePassword(String oldPassword,String newPassword) async{
    final sharedPrefs=await SharedPreferences.getInstance();
    final String tokenValue=sharedPrefs.getString(Service.tokenPrefKey)??"";
    Uri uri=Uri.parse(Service.baseApi+Service.changePassApi);
    http.Response response=await http.put(
      uri,
      body: {
        oldPasswordKey:oldPassword,
        newPasswordKey:newPassword

      },
      headers: {
        'Authorization':"Token $tokenValue"
      }
    );
    if(response.statusCode>299) throw HttpException(message: response.body.toString());

  }

  Future<void> resetPasswordEmail(String email) async{
    Uri uri=Uri.parse(Service.baseApi+Service.resetPassword);
    http.Response response= await http.post(
      uri,
      body: {
        emailKey:email
      }
    );
    if(response.statusCode>299) throw HttpException(message: response.body.toString());

  }

  Future<void> confirmResetPassword(String token,String newPassword) async{
    Uri uri=Uri.parse(Service.baseApi+Service.resetPasswordConfirm);
    http.Response response =await http.post(
      uri,
      body: {
        tokenKey:token,
        passwordKey:newPassword
      }
    );
    if(response.statusCode>299) throw HttpException(message: response.body.toString());
  }
}