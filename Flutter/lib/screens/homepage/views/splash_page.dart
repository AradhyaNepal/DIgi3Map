import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/logo_widget.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/auth/sign_in.dart';
import 'package:digi3map/screens/homepage/widgets/CustomLinearProgressIndicator.dart';
import 'package:digi3map/testing_all_navigation.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {

  AudioCache player = AudioCache();
  int totalDuration=10;




  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late Timer _timer;
  final ValueNotifier<bool> _cancelPressed=ValueNotifier(false);
  @override
  void initState() {
    // TODO: implement initState

    widget.player.play(AssetsLocation.splashPageSoundLocation);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _timer=Timer(Duration(seconds: widget.totalDuration),(){
        navigateToAnotherPage();
      });
    });


    super.initState();
  }

  void navigateToAnotherPage(){
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context)=>const TestingAllNavigation()));
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
                Constants.kSmallBox,
                Image.asset(AssetsLocation.reverseFlashLocation),
                Constants.kSmallBox,
                CustomLinearProgressIndicator(
                  totalSeconds:widget.totalDuration,
                  cancelPressed: _cancelPressed,
                ),
                Constants.kSmallBox,
                IconButton(
                  onPressed:(){
                    setState(() {
                      _cancelPressed.value=true;
                    });
                    _timer.cancel();
                    print("ouch you touched me!!");
                    navigateToAnotherPage();
                  },
                  icon: const FittedBox(
                    child: Icon(
                        Icons.skip_next
                    ),
                  ),
                ),
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
