import 'dart:math';

import 'package:digi3map/common/constants.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/widgets/milestone_widget.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/widgets/total_coins_widget.dart';
import 'package:digi3map/screens/habits/view/habits_create.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MileStonePage extends StatelessWidget {
  const MileStonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>  AddHabits()));
          },
          child: Icon(
              Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
        body: Container(
          height: size.height,
          width: size.width,
          padding: Constants.kPagePaddingNoDown,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Habits Milestone',
                style: Styles.bigHeading,
              ),
              TotalCoinsWidget(),
              Constants.kSmallBox,
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    for(int i=0;i<25;i++)
                      MileStoneWidget(progressValue: Random().nextInt(50)+60,),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}


