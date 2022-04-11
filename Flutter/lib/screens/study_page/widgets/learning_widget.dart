import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_alert_dialog.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/data/models/diet_model.dart';
import 'package:digi3map/screens/diet/widgets/failed_success_diet_widget.dart';
import 'package:digi3map/screens/homepage/provides/multiplication_provider.dart';
import 'package:digi3map/screens/study_page/provider/learning_provider.dart';
import 'package:digi3map/screens/study_page/widgets/learning_doing.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LearningWidget extends StatefulWidget {
  final LearningModel learningModel;

  const LearningWidget({
    required this.learningModel,
    Key? key,
  }) : super(key: key);

  @override
  State<LearningWidget> createState() => _LearningWidgetState();
}

class _LearningWidgetState extends State<LearningWidget> {
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Consumer<MultiplicationProvider>(
        builder: (context,provider,child) {
          LearningModel learningModel=LearningModel(
              id: widget.learningModel.id,
              heading: widget.learningModel.heading,
              totalMinutes: (widget.learningModel.totalMinutes*provider.multiplication).toInt(),
              image: widget.learningModel.image
          );
          if(learningModel.totalMinutes==0) learningModel.totalMinutes=1;
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            color: ColorConstant.kGreyCardColor,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Card(
                        child: Image.asset(learningModel.image),
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  learningModel.heading,
                                  style: Styles.mediumHeading,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.edit,
                                  color: ColorConstant.kIconColor,
                                ),
                              )
                            ],
                          ),
                          Constants.kSmallBox,
                          Text(learningModel.heading+" For ${learningModel.totalMinutes} Minutes."),
                          Constants.kSmallBox,
                          isLoading?
                          Center(
                            child: CustomCircularIndicator(),
                          ):Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Consumer<LearningProvider>(
                                  builder: (context,provider,child) {
                                    return ElevatedButton(
                                        style:
                                            ElevatedButton.styleFrom(primary: Colors.red),
                                        onPressed: () {

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
                                                await provider.addTransaction(learningModel.id);
                                                await provider.addLearningPoints(skipped: true);

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
                                        child: Text(
                                          "Skip",
                                          style: Styles.smallHeading,
                                        ));
                                  }
                                ),
                              ),
                              Constants.kSmallBox,
                              Consumer<LearningProvider>(
                                builder: (context,provider,child) {
                                  return Expanded(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context)=>LearningDoing(
                                                      learningModel: learningModel,
                                                    provider: provider,
                                                  )
                                              )
                                          );
                                        },
                                        child: Text(
                                          "Start",
                                          style: Styles.smallHeading,
                                        )),
                                  );
                                }
                              ),
                            ],
                          )
                        ],
                      )),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
