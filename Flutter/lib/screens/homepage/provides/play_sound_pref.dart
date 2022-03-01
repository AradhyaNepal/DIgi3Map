import 'package:digi3map/data/services/services_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaySoundPrefs{


  Future<bool> playSound() async{
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    return sharedPreferences.getBool(Service.playSound)??true;
  }

  void toggleValue() async{
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    sharedPreferences.setBool(Service.playSound, !(await playSound()));
  }
}