import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_alert_dialog.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/homepage/provides/random_provider.dart';
import 'package:digi3map/screens/homepage/views/random_sets_task_widget.dart';
import 'package:digi3map/screens/homepage/views/random_sets_timer.dart';
import 'package:digi3map/screens/homepage/views/random_task_add_edit.dart';
import 'package:digi3map/screens/homepage/views/random_timer_widget.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RandomTaskWidget extends StatefulWidget {
  final RandomTaskModal randomTaskModal;
  const RandomTaskWidget({
    required this.randomTaskModal,
    Key? key
  }) : super(key: key);

  @override
  State<RandomTaskWidget> createState() => _RandomTaskWidgetState();
}

class _RandomTaskWidgetState extends State<RandomTaskWidget> {
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {

    final size=MediaQuery.of(context).size;
    return Consumer<RandomProvider>(
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
                                Service.baseApiNoDash+widget.randomTaskModal.imagePath,
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
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    widget.randomTaskModal.name,
                                    style: Styles.mediumHeading,
                                  ),
                                ),
                                IconButton(
                                  onPressed: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context)=>RandomTaskAddEdit(
                                                provider: provider,
                                              modal: widget.randomTaskModal,
                                            )
                                        )
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: ColorConstant.kIconColor,
                                  ),
                                )
                              ],
                            ),
                            Constants.kVerySmallBox,
                            getDescription(),

                            Constants.kVerySmallBox,
                            isLoading?
                            Center(
                              child: CustomCircularIndicator(),
                            ):Consumer<RandomProvider>(
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
                                                    await provider.deleteRandomTask(widget.randomTaskModal.id??0);

                                                  }
                                                  catch (e){
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
                                              if(widget.randomTaskModal.type=="Todo"){
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
                                                      await provider.deleteRandomTask(widget.randomTaskModal.id??0);

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
                                              else if(widget.randomTaskModal.type=="Timer"){
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context)=>RandomTimerDoing(randomModal: widget.randomTaskModal, provider: provider)
                                                    )
                                                );
                                              }
                                              else if(widget.randomTaskModal.type=="Sets & Task"){
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context)=>RandomTaskSetsTask(randomTaskModal: widget.randomTaskModal, randomProvider: provider)
                                                    )
                                                );
                                              }
                                              else{
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context)=>RandomSetsTimerDoing(randomModal: widget.randomTaskModal, provider: provider)
                                                    )
                                                );
                                              }

                                            },
                                            child: Text(widget.randomTaskModal.type=="Todo"?"Done":"Start")
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
    String type=widget.randomTaskModal.type;
    if(type=="Todo"){
      return Text(
          widget.randomTaskModal.description??""
      );
    }else if(type=="Timer"){
      return Text(
        "${widget.randomTaskModal.time??0} Minutes",
        style: Styles.smallHeading,
      );
    }else if(type=="Sets & Task" || type =="Sets & Timer"){
      bool setsAndTask=type=="Sets & Task";
      int sets=widget.randomTaskModal.sets??0;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$sets Sets (${widget.randomTaskModal.rest} min Rest)",
            style: TextStyle(
              fontWeight: FontWeight.bold,

            ),
          ),
          Column(
            children: [
              for(int i=0;i<sets;i++)
                Text(
                  setsAndTask?
                  "Sets ${i+1}: ${widget.randomTaskModal.description}":
                  "Sets ${i+1}: ${widget.randomTaskModal.time} Minutes",
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
