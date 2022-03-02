import 'package:digi3map/common/constants.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/homepage/widgets/energy_filter_widget.dart';
import 'package:digi3map/screens/study_page/widgets/heading_widget.dart';
import 'package:digi3map/screens/study_page/widgets/study_widget.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class StudyPage extends StatelessWidget {
  const StudyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          padding: Constants.kPagePaddingNoDown,
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                  "Study Routine",
                style: Styles.bigHeading
              ),
              Constants.kVerySmallBox,
              HeadingWidget(),
              Constants.kVerySmallBox,
              Expanded(
                child: StudyListView(),
                ),
                ]
              )
          ),
        ),
      );

  }
}

class StudyListView extends StatelessWidget {
  const StudyListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        for(int i=1;i<25;i++)
          StudyWidget(number: i,)
      ],
    );
  }
}
