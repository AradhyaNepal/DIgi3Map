
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/view/habits_chain_page.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/view/habits_graph.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/view/milestone_page.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/widgets/coin_value_widget.dart';
import 'package:digi3map/screens/habits/view/habits_read_delete_update.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
class MileStone{
  int habitId;
  String heading, subheading, imageUrl;
  int progress,coins;
  bool compulsoryHabit,showNavigator;//Compulsory habit can't be clicked for Editing and deleting. And It loads local image
  MileStone({
    required this.habitId,
    required this.heading,
    required this.subheading,
    required this.coins,
    required this.imageUrl,
    required this.progress,
    this.showNavigator=true,
    this.compulsoryHabit=false
  });
}
class MileStoneWidget extends StatelessWidget {
  final MileStone mileStone;

  MileStoneWidget({
    required this.mileStone,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int progress=mileStone.progress;
    int maxLimit=100;
    if(progress>100) progress=100;
    return InkWell(
      onTap: (mileStone.showNavigator && !mileStone.compulsoryHabit)?(){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  HabitsReadDeleteUpdate(id: mileStone.habitId,)));
      }:null,
      child: FittedBox(
        child: Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
          child: Card(
            elevation: 5,
            margin: const EdgeInsets.all(0),
            color:ColorConstant.kGreyCardColor,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                      child: mileStone.compulsoryHabit?
                      Image.asset(
                          mileStone.imageUrl
                      ):
                          Image.network(
                            Service.baseApiNoDash+mileStone.imageUrl
                          )
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  mileStone.heading,
                                  style: Styles.mediumHeading,
                                ),
                              ),
                              SizedBox(width: 5,),
                              mileStone.showNavigator?IconButton(
                                  onPressed: (){
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) =>  HabitChain()));
                                  },
                                  icon: Icon(
                                    Icons.pie_chart
                                  )
                              ):SizedBox()
                            ],
                          ),
                          Text(
                              mileStone.subheading,
                              style:Styles.smallHeading
                          ),
                          Constants.kVerySmallBox,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Row(
                                  children: [
                                    Expanded(
                                        flex: progress,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(3),bottomLeft: Radius.circular(3)),
                                            color: ColorConstant.kBlueColor,
                                          ),
                                          height: 10,
                                        )
                                    ),
                                    Expanded(
                                        flex: maxLimit-progress,
                                        child: Container(
                                          height: 10,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(3),bottomRight: Radius.circular(3)),
                                            color: ColorConstant.kBlueColor.withOpacity(0.3),
                                          ),
                                        )
                                    )
                                  ],
                                ),

                              ],
                            ),
                          ),


                        ],
                      )
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                      child: FittedBox(
                          child: Column(
                            children: [
                              CoinValueWidget(
                                value: mileStone.coins,
                              ),
                              if(progress==100)
                                TextButton(
                                    onPressed: (){},
                                    child: Text(
                                      "Collect",
                                      style: Styles.blueHighlight,
                                    )
                                )
                            ],
                          )
                      )
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
