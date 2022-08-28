import 'dart:async';
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/screens/fitness_page/provider/fitness_provider.dart';
import 'package:digi3map/screens/fitness_page/widgets/fitness_widget.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkoutDoing extends StatefulWidget {
  final FitnessModel fitnessModel;
  final FitnessProvider fitnessProvider;
  const WorkoutDoing({
    required this.fitnessProvider,
    required this.fitnessModel,
    Key? key
  }) : super(key: key);

  @override
  State<WorkoutDoing> createState() => _WorkoutDoingState();
  static String getMinuteSeconds(int totalSeconds){
    int convertedMinute=totalSeconds~/60;
    int seconds=totalSeconds-convertedMinute*60;
    return convertedMinute.toString().padLeft(2,"0")+":"+seconds.toString().padLeft(2,"0");
  }
}

class _WorkoutDoingState extends State<WorkoutDoing> {
  int currentSet=1;
  bool itsRest=false;
  int completedSets=0;
  bool isDoingTransaction=false;
  late Timer periodicTimer;
  late Timer totalTimer;
  late int totalSeconds;



  void startTimer(){
    totalSeconds=widget.fitnessModel.restMinute*60;
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
      value: widget.fitnessProvider,
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
                  widget.fitnessModel.name,
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
                          child: Image.asset(
                              widget.fitnessModel.image
                          ),
                        ),
                        itsRest?SizedBox():Text(
                            "Sets :$currentSet/${widget.fitnessModel.setsCount}",
                          textAlign: TextAlign.center,
                          style: Styles.mediumHeading
                        ),
                        SizedBox(height: itsRest?0:10,),
                        itsRest?SizedBox():Text(
                          "${widget.fitnessModel.weight} Kg with ${widget.fitnessModel.reps} reps",
                          textAlign: TextAlign.center,
                          style: Styles.bigHeading,
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Expanded(
                                child: Text(
                                  "Tips:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              flex: 5,
                                child: Text(
                                    "Its not about how heavy you lift, its about whether you lift EVERY SIGNLE DAY ",
                                    style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                                ),

                            ),
                          ],
                        ),
                        Constants.kMediumBox,
                        itsRest?Text(
                          "Timer: ${WorkoutDoing.getMinuteSeconds(totalSeconds)}",
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
                    itsRest?"Next ${widget.fitnessModel.weight} Kg with ${widget.fitnessModel.reps} reps":"Next ${widget.fitnessModel.restMinute} min rest",
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
                            (widget.fitnessModel.setsCount==currentSet && !itsRest)?"Completed":"Next",
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
        if(currentSet==widget.fitnessModel.setsCount){
          setState(() {
            isDoingTransaction=true;
          });
          bool taskCompleted=completedSets>(currentSet~/2);
          await widget.fitnessProvider.addFitnessPoints(skipped: !taskCompleted);
          await widget.fitnessProvider.addTransaction(widget.fitnessModel.id);

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
