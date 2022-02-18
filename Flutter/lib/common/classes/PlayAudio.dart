import 'package:audioplayers/audioplayers.dart';

class PlayAudio{
  static void playAudio(String location){
    final AudioCache player = AudioCache();
    player.play(location);
  }
}