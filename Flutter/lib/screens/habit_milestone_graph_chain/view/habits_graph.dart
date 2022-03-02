import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/graph_time_widget.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/domain_list_graph/widget/graph_widget.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/widgets/milestone_widget.dart';
import 'package:digi3map/screens/habits/widgets/habits_focus_widget.dart';
import 'package:digi3map/screens/habits/widgets/open_chain_navigation_widget.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HabitsGraph extends StatelessWidget {
  const HabitsGraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
            "Graph",
          style: Styles.opacityHeadingStyle,
        ),
        GraphTimeFrame(),
        Constants.kSmallBox,
        Container(
          height: 500,
          width: size.width,
          color: ColorConstant.kLightBlackColor,
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(AssetsLocation.coinIconLocation),
              SizedBox(width: 5,),
              Expanded(
                child: GraphWidget(
                  units: 10,
                  forCoin: true,
                  yAxisIntList: [10,100,120,5,50],
                  xAxisStringList: ['1 Jan','15 Jan','1 Feb','15 Feb','1 March'],
                ),
              ),
            ],
          ),
        ),
        Constants.kSmallBox,
        Text(
          "Milestone",
          style: Styles.opacityHeadingStyle,
        ),
        Constants.kVerySmallBox,
        MileStoneWidget(progressValue: 12,showNavigator: false,),
        Constants.kVerySmallBox,


      ],
    );
  }
}
