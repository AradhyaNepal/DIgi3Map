import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/logo_widget.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/auth/sign_in.dart';
import 'package:digi3map/screens/homepage/widgets/CustomLinearProgressIndicator.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  AudioCache player = AudioCache();
  bool _playSound=true;
  int value=0;
  @override
  void initState() {
    // TODO: implement initState
    player.play(AssetsLocation.splashPageSoundLocation);
    late Timer timer;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      timer=Timer.periodic(Duration(milliseconds: 700), (timer) {
        setState(() {
          value+=1;
        });
      });
      Future.delayed(Duration(seconds: 7)).then((value) {
        timer.cancel();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=>SignIn()));
      });
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;


    return SafeArea(
        child: Scaffold(
          body: Container(
            height: size.height*0.8,
            padding: Constants.kPagePadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                    child: LogoWidget()
                ),
                const Text(
                    'Self Productivity App',
                  style: Styles.subLogoTextStyle,
                ),
                IconButton(
                  onPressed: (){
                    setState(() {
                      _playSound=!_playSound;
                    });
                  },
                  icon: FittedBox(
                    child: Icon(
                      _playSound?Icons.volume_up_outlined:Icons.volume_off_outlined,
                    ),
                  ),
                ),
                Constants.kSmallBox,
                Image.asset(AssetsLocation.reverseFlashLocation),
                Constants.kSmallBox,
                CustomLinearProgressIndicator(value)
              ],
            ),
          ),
        )
    );
  }
}
