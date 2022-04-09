import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_alert_dialog.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/habits/provider/habit_task_provider.dart';
import 'package:digi3map/screens/habits/provider/habits_provider.dart';
import 'package:digi3map/screens/habits/view/habit_timer_doing.dart';
import 'package:digi3map/screens/habits/widgets/habit_sets_task_doing.dart';
import 'package:digi3map/screens/habits/widgets/habit_task_timer_doing.dart';
import 'package:digi3map/screens/homepage/provides/random_provider.dart';
import 'package:digi3map/screens/homepage/views/random_sets_task_widget.dart';
import 'package:digi3map/screens/homepage/views/random_sets_timer.dart';
import 'package:digi3map/screens/homepage/views/random_task_add_edit.dart';
import 'package:digi3map/screens/homepage/views/random_timer_widget.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HabitTaskWidget extends StatefulWidget {
  final Habit habitModal;
  const HabitTaskWidget({
    required this.habitModal,
    Key? key
  }) : super(key: key);

  @override
  State<HabitTaskWidget> createState() => _HabitTaskWidgetState();
}

class _HabitTaskWidgetState extends State<HabitTaskWidget> {
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {

    final size=MediaQuery.of(context).size;
    return Consumer<HabitTaskProvider>(
        builder: (context,provider,child) {
          return Container(
            width: size.width,
            margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
            child: Card(
              elevation: 5,
              color: ColorConstant.kGreyCardColor,
              margin: const EdgeInsets.all(0),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Card(
                            margin: const EdgeInsets.all(0),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: SizedBox(
                                height: 100,
                                child: Image.network(
                                  Service.baseApiNoDash+widget.habitModal.photoUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ) ,
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                widget.habitModal.name,
                                style: Styles.mediumHeading,
                              ),
                              Constants.kVerySmallBox,
                              getDescription(),

                              Constants.kVerySmallBox,
                              isLoading?
                              Center(
                                child: CustomCircularIndicator(),
                              ):Consumer<HabitTaskProvider>(
                                  builder: (context,provider,child) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(primary: Colors.red),
                                              onPressed: (){
                                                showDialog(
                                                    context: context,
                                                    builder: (context){
                                                      return  CustomAlertDialog(
                                                        heading: "Give Up",
                                                        subText:  "Do You Really Want To Give Up?",

                                                      );
                                                    }
                                                ).then((value) async{
                                                  if(value==true){
                                                    setState(() {
                                                      isLoading=true;
                                                    });
                                                    try{
                                                      await provider.addTransaction(habitId: widget.habitModal.id,failed: true);

                                                    }
                                                    catch (e){
                                                      print(e.toString());
                                                      CustomSnackBar.showSnackBar(context, e.toString());
                                                    }

                                                    setState(() {
                                                      isLoading=false;
                                                    });
                                                  }
                                                });
                                              },
                                              child: Text("Failed")
                                          ),
                                        ),
                                        Constants.kSmallBox,
                                        Expanded(
                                          child: ElevatedButton(
                                              onPressed: (){
                                                if(widget.habitModal.widgetType=="Todo"){
                                                  showDialog(
                                                      context: context,
                                                      builder: (context){
                                                        return  CustomAlertDialog(
                                                          heading: "Completed",
                                                          subText:  "Had You Completed The Task?",

                                                        );
                                                      }
                                                  ).then((value) async{
                                                    if(value==true){
                                                      setState(() {
                                                        isLoading=true;
                                                      });
                                                      try{
                                                        await provider.addTransaction(habitId: widget.habitModal.id,failed: false);

                                                      }
                                                      catch (e){
                                                        CustomSnackBar.showSnackBar(context, e.toString());
                                                      }

                                                      setState(() {
                                                        isLoading=false;
                                                      });
                                                    }
                                                  });
                                                }
                                                else if(widget.habitModal.widgetType=="Timer"){
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context)=>HabitTimerDoing(habitModal: widget.habitModal, provider: provider)
                                                      )
                                                  );
                                                }
                                                else if(widget.habitModal.widgetType=="Sets & Task"){
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context)=>HabitSetsTaskDoing(habitModal: widget.habitModal, provider: provider)
                                                      )
                                                  );
                                                }
                                                else{
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context)=>HabitSetsTimerDoing(habitModal: widget.habitModal, provider: provider)
                                                      )
                                                  );
                                                }

                                              },
                                              child: Text(widget.habitModal.widgetType=="Todo"?"Done":"Start")
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                              )
                            ],
                          ),
                        ),
                      ],
                    ),


                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  Widget getDescription(){
    String type=widget.habitModal.widgetType;
    if(type=="Todo"){
      return Text(
          widget.habitModal.description
      );
    }else if(type=="Timer"){
      return Text(
        "${widget.habitModal.time??0} Minutes",
        style: Styles.smallHeading,
      );
    }else if(type=="Sets & Task" || type =="Sets & Timer"){
      bool setsAndTask=type=="Sets & Task";
      int sets=widget.habitModal.sets??0;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$sets Sets (${widget.habitModal.rest} min Rest)",
            style: TextStyle(
              fontWeight: FontWeight.bold,

            ),
          ),
          Column(
            children: [
              for(int i=0;i<sets;i++)
                Text(
                  setsAndTask?
                  "Sets ${i+1}: ${widget.habitModal.description}":
                  "Sets ${i+1}: ${widget.habitModal.time} Minutes",
                ),
            ],
          ),
        ],
      );
    }
    else{
      return Text(
          type
      );
    }


  }
}
