import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/fitness_page/view/workout_doing.dart';
import 'package:digi3map/screens/homepage/provides/random_provider.dart';
import 'package:digi3map/screens/study_page/provider/learning_provider.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class RandomTimerDoing extends StatefulWidget {
  final RandomTaskModal randomModal;
  final RandomProvider provider;
  const RandomTimerDoing({
    required this.randomModal,
    required this.provider,
    Key? key
  }) : super(key: key);

  @override
  State<RandomTimerDoing> createState() => _RandomTimerDoingState();
}

class _RandomTimerDoingState extends State<RandomTimerDoing> {
  bool timerRunning=true;
  int totalSeconds=0;
  late Timer periodicTimer;
  late Timer totalTimer;
  bool isLoading=false;
  @override
  void initState() {
    super.initState();
    totalSeconds=(widget.randomModal.time??0)*60;
    print("$totalSeconds\n${widget.randomModal.time}");
    startTimer();
  }

  void startTimer(){
    periodicTimer=Timer.periodic(
        Duration(seconds: 1)
        , (timer) {
      setState(() {
        totalSeconds--;
      });
    }
    );
    totalTimer=Timer(
        Duration(seconds: totalSeconds),() async{
      setState(() {
        isLoading=true;
      });
      await widget.provider.deleteRandomTask(widget.randomModal.id??0);

      CustomSnackBar.showSnackBar(context, "Task Successfully Completed");
      setState(() {
        isLoading=false;
      });
      Navigator.pop(context);

    }
    );
  }


  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }
  void cancelTimer(){
    periodicTimer.cancel();
    totalTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          padding: Constants.kPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.randomModal.name,
                style: Styles.bigHeading,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Constants.kMediumBox,
                    SizedBox(
                      width: 250,
                      height: 250,
                      child: CachedNetworkImage(
                          imageUrl:Service.baseApiNoDash+widget.randomModal.imagePath
                      ),
                    ),
                    Constants.kSmallBox,
                    Text(
                      "Every Single Day Counts",
                      style: Styles.mediumHeading,
                    ),
                    Spacer(),
                    Text(
                      "Timer: ${WorkoutDoing.getMinuteSeconds(totalSeconds)}",
                      style: Styles.bigHeading,
                    ),
                    Spacer(),
                  ],
                ),
              ),

              SizedBox(height: 10,),
              isLoading?
              Center(
                child: CustomCircularIndicator(),
              ):Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: Styles.mediumHeading,
                        )
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: (){
                          if(timerRunning){
                            cancelTimer();
                          }
                          else{
                            startTimer();
                          }
                          timerRunning=!timerRunning;
                          setState(() {

                          });
                        },
                        child: Text(
                          timerRunning?"Stop Timer":"Start Timer",
                          style: Styles.mediumHeading,
                        )
                    ),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }

}