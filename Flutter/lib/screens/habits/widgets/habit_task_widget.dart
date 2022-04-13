import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_alert_dialog.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/habits/provider/habit_task_provider.dart';
import 'package:digi3map/screens/habits/provider/habits_provider.dart';
import 'package:digi3map/screens/habits/view/habit_timer_doing.dart';
import 'package:digi3map/screens/habits/view/habits_read_delete_update.dart';
import 'package:digi3map/screens/habits/widgets/habit_sets_task_doing.dart';
import 'package:digi3map/screens/habits/widgets/habit_task_timer_doing.dart';
import 'package:digi3map/screens/homepage/provides/multiplication_provider.dart';
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
    return FittedBox(
      child: Consumer<MultiplicationProvider>(
        builder: (context,provider,child) {
          Habit habitModal=Habit(
            id: widget.habitModal.id,
              domainName: widget.habitModal.domainName,
              name: widget.habitModal.name,
              domainId: widget.habitModal.domainId,
              photoUrl: widget.habitModal.photoUrl,
              widgetType: widget.habitModal.widgetType,
              description: widget.habitModal.description,
              progress: widget.habitModal.progress,
            domainPriority: widget.habitModal.domainPriority
          );
          if(widget.habitModal.time!=null)habitModal.time=(widget.habitModal.time!*provider.multiplication).toInt();
          if(widget.habitModal.sets!=null)habitModal.sets=(widget.habitModal.sets!*provider.multiplication).toInt();
          if(widget.habitModal.rest!=null)habitModal.rest=(widget.habitModal.rest!)~/provider.multiplication;

          if(habitModal.time==0)habitModal.time=1;
          if(habitModal.sets==0)habitModal.sets=1;
          if(habitModal.rest==0)habitModal.rest=1;
          return Consumer<HabitTaskProvider>(

              builder: (context,provider,child) {

                return InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context)=>HabitsReadDeleteUpdate(id: habitModal.id)
                        )
                    ).then((value) {
                      provider.getHabitsList();
                    });
                  },
                  child: Container(
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
                                          Service.baseApiNoDash+habitModal.photoUrl,
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
                                        habitModal.name,
                                        style: Styles.mediumHeading,
                                      ),
                                      Constants.kVerySmallBox,
                                      getDescription(habitModal),

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
                                                              await provider.addTransaction(habitId: habitModal.id,failed: true);

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
                                                        if(habitModal.widgetType=="Todo"){
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
                                                                await provider.addTransaction(habitId: habitModal.id,failed: false);

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
                                                        else if(habitModal.widgetType=="Timer"){
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context)=>HabitTimerDoing(habitModal: habitModal, provider: provider)
                                                              )
                                                          );
                                                        }
                                                        else if(habitModal.widgetType=="Sets & Task"){
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context)=>HabitSetsTaskDoing(habitModal: habitModal, provider: provider)
                                                              )
                                                          );
                                                        }
                                                        else{
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context)=>HabitSetsTimerDoing(habitModal: habitModal, provider: provider)
                                                              )
                                                          );
                                                        }

                                                      },
                                                      child: Text(habitModal.widgetType=="Todo"?"Done":"Start")
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
                  ),
                );
              }
          );
        }
      ),
    );
  }

  Widget getDescription(Habit habitModal){
    String type=habitModal.widgetType;
    if(type=="Todo"){
      return Text(
          habitModal.description
      );
    }else if(type=="Timer"){
      return Text(
        "${habitModal.time??0} Minutes",
        style: Styles.smallHeading,
      );
    }else if(type=="Sets & Task" || type =="Sets & Timer"){
      bool setsAndTask=type=="Sets & Task";
      int sets=habitModal.sets??0;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$sets Sets (${habitModal.rest} min Rest)",
            style: TextStyle(
              fontWeight: FontWeight.bold,

            ),
          ),
          Column(
            children: [
              for(int i=0;i<sets;i++)
                Text(
                  setsAndTask?
                  "Sets ${i+1}: ${habitModal.description}":
                  "Sets ${i+1}: ${habitModal.time} Minutes",
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
