import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_alert_dialog.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/common/widgets/selection_collection.dart';
import 'package:digi3map/common/widgets/selection_unit.dart';
import 'package:digi3map/screens/fitness_page/provider/fitness_provider.dart';
import 'package:digi3map/screens/fitness_page/view/fitness_edit.dart';
import 'package:digi3map/screens/fitness_page/view/workout_doing.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class FitnessModel{
  final int id;
  final int restMinute;
  final int setsCount;
  final String name;
  final String image;
  final List<String> musclesTargeted;
  final String weightAndRep;
  FitnessModel({
    required this.restMinute,
    required this.id,
    required this.setsCount,
    required this.name,
    required this.image,
    required this.musclesTargeted,
    required this.weightAndRep

  });
}
class FitnessWidget extends StatefulWidget {
  final FitnessModel fitnessModel;
  const FitnessWidget({
    required this.fitnessModel,
    Key? key,
  }) : super(key: key);

  @override
  State<FitnessWidget> createState() => _FitnessWidgetState();
}

class _FitnessWidgetState extends State<FitnessWidget> {
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        color: ColorConstant.kGreyCardColor,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [

              Expanded(
                  flex: 2,
                  child: Card(
                    margin: EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Image.asset(
                          widget.fitnessModel.image
                      ),
                    ),
                  )
              ),
              SizedBox(width: 10,),
              Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                                "${widget.fitnessModel.id}) ${widget.fitnessModel.name}",
                              style: Styles.mediumHeading,
                            ),
                          ),
                          IconButton(
                              onPressed: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => FitnessEditAdd()));
                              },
                              icon: Icon(
                                Icons.edit,
                                color: ColorConstant.kIconColor,
                              )
                          )
                        ],
                      ),
                      Constants.kVerySmallBox,
                      Text(
                        "${widget.fitnessModel.setsCount} Sets (${widget.fitnessModel.restMinute} min Rest)",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                      Column(
                        children: [
                          for(int i=0;i<5;i++)
                          Text(
                              widget.fitnessModel.weightAndRep,
                          ),
                        ],
                      ),
                      Constants.kVerySmallBox,
                      Text(
                        "Targeted Muscle",
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Wrap(
                        children: [
                          for(String value in widget.fitnessModel.musclesTargeted)
                            SelectionUnit(isSelected:true, value: value)
                        ],
                      ),
                      Constants.kVerySmallBox,
                      Consumer<FitnessProvider>(
                        builder: (context,provider,child) {
                          return isLoading?Center(child: CircularProgressIndicator(),):Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.red),
                                    onPressed: (){
                                      showDialog(
                                          context: context,
                                          builder: (context){
                                            return  CustomAlertDialog(
                                              heading: "Skip",
                                              subText:  "Do You Really Want To Skip",

                                            );
                                          }
                                      ).then((value) async{
                                        if(value==true){
                                          setState(() {
                                            isLoading=true;
                                          });
                                          try{
                                            await provider.addFitnessPoints(skipped: true);
                                            await provider.addTransaction(widget.fitnessModel.id);
                                          }catch(e){
                                            CustomSnackBar.showSnackBar(context, e.toString());
                                            print(e);
                                          }
                                          setState(() {
                                            isLoading=false;
                                          });
                                        }


                                      });
                                    },
                                    child: Text(
                                      "Skip",
                                      style: Styles.mediumHeading,
                                    )
                                ),
                              ),
                              SizedBox(width: 5,),
                              Flexible(
                                child: Consumer<FitnessProvider>(
                                  builder: (context,provider,child) {
                                    return ElevatedButton(
                                        onPressed: (){
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) =>  WorkoutDoing(
                                                fitnessProvider: provider,
                                                fitnessModel: widget.fitnessModel,
                                              ))
                                          );
                                        },
                                        child: Text(
                                          "Start",
                                          style: Styles.mediumHeading,
                                        )
                                    );
                                  }
                                ),
                              ),
                            ],
                          );
                        }
                      )



                    ],
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }
}
