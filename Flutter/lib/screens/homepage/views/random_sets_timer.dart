import 'dart:async';
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/fitness_page/view/workout_doing.dart';
import 'package:digi3map/screens/homepage/provides/random_provider.dart';
import 'package:digi3map/screens/study_page/provider/implementing_provider.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RandomSetsTimerDoing extends StatefulWidget {
  final RandomTaskModal randomModal;
  final RandomProvider provider;
  const RandomSetsTimerDoing({
    required this.provider,
    required this.randomModal,
    Key? key
  }) : super(key: key);

  @override
  State<RandomSetsTimerDoing> createState() => _RandomSetsTimerDoingState();

}

class _RandomSetsTimerDoingState extends State<RandomSetsTimerDoing> {
  int currentSet=1;
  bool itsRest=false;
  int completedSets=0;
  bool isDoingTransaction=false;
  late Timer periodicTimer;
  late Timer totalTimer;
  late int totalSeconds;
  bool stopped=false;


  @override
  void initState() {
    totalSeconds=(widget.randomModal.time??0)*60;
    startTimer(totalSeconds);
    super.initState();
  }
  void startTimer(int totalSeconds){
    this.totalSeconds=totalSeconds;

    periodicTimer=Timer.periodic(
        Duration(seconds: 1), (value){
      setState(() {
        this.totalSeconds--;
      });
    }
    );
    totalTimer=Timer(Duration(seconds: this.totalSeconds), (){
      periodicTimer.cancel();
      buttonClicked();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return ChangeNotifierProvider.value(
      value: widget.provider,
      child: SafeArea(
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
                        child: Image.network(
                            Service.baseApiNoDash+widget.randomModal.imagePath
                        ),
                      ),
                      Constants.kSmallBox,
                      itsRest?SizedBox():Center(
                        child: Text(
                            "Set: $currentSet/${widget.randomModal.sets}",
                            textAlign: TextAlign.center,
                            style:Styles.mediumHeading
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Center(
                        child: Text(
                            "Every Day Matters",
                            textAlign: TextAlign.center,
                            style:Styles.mediumHeading
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${itsRest?"Rest":"Work"} \nTimer: ${WorkoutDoing.getMinuteSeconds(totalSeconds)} Min",
                        textAlign: TextAlign.center,
                        style: Styles.bigHeading,
                      ),

                      Spacer(),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    itsRest?"Next ${widget.randomModal.time} min Work":"Next ${widget.randomModal.rest} min rest",
                    style: Styles.mediumHeading,
                  ),
                ),
                SizedBox(height: 10,),
                isDoingTransaction?Center(
                  child: CustomCircularIndicator(),
                ):Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: (){
                            buttonClicked(skipButton: true);
                          },
                          child: Text(
                            "Skip",
                            style: Styles.mediumHeading,
                          )
                      ),
                    ),
                    SizedBox(width: 10,),
                    itsRest?SizedBox():Expanded(
                      child:  ElevatedButton(
                          onPressed: (){
                            if(stopped){
                              startTimer(totalSeconds);
                            }else{
                              closeTimer();

                            }
                            stopped=!stopped;
                            setState(() {

                            });


                          },
                          child: Text(

                            stopped?"Start":"Stop",
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
      ),
    );
  }

  void buttonClicked({bool skipButton=false}) async{
    try{
      if(!itsRest){
        if(!skipButton)completedSets++;
        if(currentSet==widget.randomModal.sets){
          setState(() {
            isDoingTransaction=true;
          });
          bool taskCompleted=completedSets>(currentSet~/2);
          await widget.provider.deleteRandomTask(widget.randomModal.id??0);

          CustomSnackBar.showSnackBar(context, taskCompleted?"Task Completed":"Task Failed");
          Navigator.pop(context);
        }
        currentSet++;
        closeTimer();
        startTimer((widget.randomModal.time??0)*60);
      }else{
        closeTimer();
        startTimer((widget.randomModal.rest??0)*60);
      }
      itsRest=!itsRest;
      setState(() {

      });
    }catch (e,e2){
      print(e.toString()+"\n"+e2.toString());
      CustomSnackBar.showSnackBar(context, e.toString());
      setState(() {
        isDoingTransaction=false;
      });
    }
  }



  void closeTimer(){

    try{
      periodicTimer.cancel();
      totalTimer.cancel();
    }catch(e){

    }
  }
  @override
  void dispose() {
    closeTimer();
    super.dispose();

  }
}
