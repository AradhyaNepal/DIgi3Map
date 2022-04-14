import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/habits/provider/habit_task_provider.dart';
import 'package:digi3map/screens/habits/provider/habits_provider.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HabitSetsTaskDoing extends StatefulWidget {
  final Habit habitModal;
  final HabitTaskProvider provider;
  const HabitSetsTaskDoing({
    required this.provider,
    required this.habitModal,
    Key? key
  }) : super(key: key);

  @override
  State<HabitSetsTaskDoing> createState() => _HabitSetsTaskDoingState();
  static String getMinuteSeconds(int totalSeconds){
    int convertedMinute=totalSeconds~/60;
    int seconds=totalSeconds-convertedMinute*60;
    return convertedMinute.toString().padLeft(2,"0")+":"+seconds.toString().padLeft(2,"0");
  }
}

class _HabitSetsTaskDoingState extends State<HabitSetsTaskDoing> {
  int currentSet=1;
  bool itsRest=false;
  int completedSets=0;
  bool isDoingTransaction=false;
  late Timer periodicTimer;
  late Timer totalTimer;
  late int totalSeconds;



  void startTimer(){
    totalSeconds=(widget.habitModal.rest??0)*60;
    print(totalSeconds);
    periodicTimer=Timer.periodic(
        Duration(seconds: 1), (value){
      setState(() {
        totalSeconds--;
      });
    }
    );
    totalTimer=Timer(Duration(seconds: totalSeconds), (){
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
                  widget.habitModal.name,
                  style: Styles.bigHeading,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Constants.kMediumBox,
                        SizedBox(
                          width: 250,
                          height: 250,
                          child: CachedNetworkImage(
                              imageUrl:Service.baseApiNoDash+widget.habitModal.photoUrl
                          ),
                        ),
                        Constants.kSmallBox,
                        itsRest?SizedBox():Text(
                            "Sets :$currentSet/${widget.habitModal.sets}",
                            textAlign: TextAlign.center,
                            style: Styles.mediumHeading
                        ),
                        SizedBox(height: itsRest?0:10,),
                        itsRest?SizedBox():Text(
                          widget.habitModal.description,
                          textAlign: TextAlign.center,
                          style: Styles.bigHeading,
                        ),
                        const SizedBox(height: 10,),
                        Text(
                            "Every Day Counts",
                            style:Styles.mediumHeading
                        ),
                        Constants.kMediumBox,
                        itsRest?Text(
                          "Timer: ${HabitSetsTaskDoing.getMinuteSeconds(totalSeconds)}",
                          style: Styles.bigHeading,
                        ):SizedBox(),
                        Constants.kMediumBox,
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    itsRest?"Next ${widget.habitModal.description}":"Next ${widget.habitModal.rest} min rest",
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
                    Expanded(
                      child:  ElevatedButton(
                          onPressed: (){
                            buttonClicked();

                          },
                          child: Text(
                            (widget.habitModal.sets==currentSet && !itsRest)?"Completed":"Next",
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
        if(currentSet==widget.habitModal.sets){
          setState(() {
            isDoingTransaction=true;
          });
          bool taskCompleted=completedSets>(currentSet~/2);
          await widget.provider.addTransaction(habitId:widget.habitModal.id,failed: !taskCompleted);


          CustomSnackBar.showSnackBar(context, taskCompleted?"Task Completed":"Task Failed");
          Navigator.pop(context);
        }
        currentSet++;
        startTimer();
      }else{
        closeTimer();
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
