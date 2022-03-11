import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/logo_widget.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/authentication/provides/auth.dart';
import 'package:digi3map/screens/homepage/provides/play_sound_pref.dart';
import 'package:digi3map/screens/homepage/views/home_page.dart';
import 'package:digi3map/screens/homepage/widgets/custom_linear_progress_indicator.dart';
import 'package:digi3map/screens/on_boarding/view/on_boarding.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {

  final AudioCache player = AudioCache();
  final int totalDuration=3;

  SplashPage({Key? key}) : super(key: key);




  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late Timer _timer;
  final ValueNotifier<bool> _cancelPressed=ValueNotifier(false);
  @override
  void initState(){
    // TODO: implement initState

    navigateSetup();

    super.initState();
  }

  void navigateSetup() async{
    bool isLogged=await Auth().isLogged();
    PlaySoundPrefs playSoundPrefs=PlaySoundPrefs();
    bool playSound=await playSoundPrefs.playSound();
    if(playSound) widget.player.play(AssetsLocation.splashPageSoundLocation);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _timer=Timer(Duration(seconds: widget.totalDuration),(){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=>isLogged?HomePage():OnBoarding()));
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;


    return SafeArea(
        child: Scaffold(
          body: Container(
            height: size.height,
            padding: Constants.kPagePadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Flexible(
                    child: LogoWidget()
                ),
                const Text(
                    'Self Productivity App',
                  style: Styles.subLogoTextStyle,
                ),
                Constants.kSmallBox,
                Image.asset(AssetsLocation.reverseFlashLocation),
                Constants.kSmallBox,
                CustomLinearProgressIndicator(
                  totalSeconds:widget.totalDuration,
                  cancelPressed: _cancelPressed,
                ),
                Constants.kSmallBox,

              ]
            )
          ),
        )
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.player.clearAll();
  }
}
