import 'package:digi3map/screens/homepage/provides/play_sound_pref.dart';
import 'package:flutter/material.dart';

class PlaySoundSwitch extends StatefulWidget {
  final PlaySoundPrefs playSoundPrefs=PlaySoundPrefs();

  PlaySoundSwitch({
    Key? key,
  }) : super(key: key);

  @override
  State<PlaySoundSwitch> createState() => _PlaySoundSwitchState();
}

class _PlaySoundSwitchState extends State<PlaySoundSwitch> {
  bool enabled=false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async{
      enabled=await widget.playSoundPrefs.playSound();
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
        value: enabled,
        onChanged: (value){
          widget.playSoundPrefs.toggleValue();
          setState(() {
            enabled=value;
          });
        }
    );
  }
}
