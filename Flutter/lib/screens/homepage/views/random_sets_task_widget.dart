import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/homepage/provides/random_provider.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RandomTaskSetsTask extends StatefulWidget {
  final RandomTaskModal randomTaskModal;
  final RandomProvider randomProvider;
  const RandomTaskSetsTask({
    required this.randomProvider,
    required this.randomTaskModal,
    Key? key
  }) : super(key: key);

  @override
  State<RandomTaskSetsTask> createState() => _RandomTaskSetsTaskState();
  static String getMinuteSeconds(int totalSeconds){
    int convertedMinute=totalSeconds~/60;
    int seconds=totalSeconds-convertedMinute*60;
    return convertedMinute.toString().padLeft(2,"0")+":"+seconds.toString().padLeft(2,"0");
  }
}

class _RandomTaskSetsTaskState extends State<RandomTaskSetsTask> {
  int currentSet=1;
  bool itsRest=false;
  int completedSets=0;
  bool isDoingTransaction=false;
  late Timer periodicTimer;
  late Timer totalTimer;
  late int totalSeconds;



  void startTimer(){
    totalSeconds=(widget.randomTaskModal.rest??0)*60;
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
      value: widget.randomProvider,
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
                  widget.randomTaskModal.name,
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
                              imageUrl:Service.baseApiNoDash+widget.randomTaskModal.imagePath
                          ),
                        ),
                        Constants.kSmallBox,
                        itsRest?SizedBox():Text(
                            "Sets :$currentSet/${widget.randomTaskModal.sets}",
                            textAlign: TextAlign.center,
                            style: Styles.mediumHeading
                        ),
                        SizedBox(height: itsRest?0:10,),
                        itsRest?SizedBox():Text(
                          widget.randomTaskModal.description??"",
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
                          "Timer: ${RandomTaskSetsTask.getMinuteSeconds(totalSeconds)}",
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
                    itsRest?"Next ${widget.randomTaskModal.description}":"Next ${widget.randomTaskModal.rest} min rest",
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
                            (widget.randomTaskModal.sets==currentSet && !itsRest)?"Completed":"Next",
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
        if(currentSet==widget.randomTaskModal.sets){
          setState(() {
            isDoingTransaction=true;
          });
          bool taskCompleted=completedSets>(currentSet~/2);
          await widget.randomProvider.deleteRandomTask(widget.randomTaskModal.id??0);


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
