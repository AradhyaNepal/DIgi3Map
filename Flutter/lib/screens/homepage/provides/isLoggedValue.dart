import 'package:digi3map/data/services/services_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IsLoggedValue{
  static Future<bool> getIsLogged() async{
    final shared= await SharedPreferences.getInstance();
    String? token=shared.getString(Service.tokenPrefKey);
    return token!=null && token!=Service.emptyTokenValue;
  }

  static void loggedIn() async{
    final shared= await SharedPreferences.getInstance();
    shared.setString(Service.tokenPrefKey,"Abcd");
  }
  static void loggedOut() async{
    final shared= await SharedPreferences.getInstance();
    shared.setString(Service.tokenPrefKey,Service.emptyTokenValue);
  }



}