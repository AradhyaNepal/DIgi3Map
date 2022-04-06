import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/screens/study_page/provider/implementing_provider.dart';
import 'package:digi3map/screens/study_page/provider/learning_provider.dart';
import 'package:digi3map/screens/study_page/widgets/heading_widget.dart';
import 'package:digi3map/screens/study_page/widgets/implement_widget.dart';
import 'package:digi3map/screens/study_page/widgets/learning_widget.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudyPage extends StatelessWidget {
  final bool forImplementing;
  const StudyPage({
    required this.forImplementing,
    Key? key
  }) : super(key: key);

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
                  forImplementing?"Implement Practically (Te)":"Learn Theory (Ti)",
                style: Styles.bigHeading
              ),
              Constants.kVerySmallBox,
              HeadingWidget(),
              Constants.kVerySmallBox,
              Expanded(
                child: forImplementing?ImplementListVew():StudyListView(),
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
    return ChangeNotifierProvider(
      create: (context)=>LearningProvider(),
      child: Consumer<LearningProvider>(
        builder: (context,provider,child) {
          return provider.isLoading?
          Center(
            child: CircularProgressIndicator(),
          ):
          provider.learningList.isEmpty?
          Center(
            child: Text(
              "Congratulation, No Have Completed All Your Learnings For Today",
              textAlign: TextAlign.center,
            ),
          ):
          ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context,index){
              return LearningWidget(learningModel: provider.learningList[index]);
            },
            itemCount: provider.learningList.length,
          );
        }
      ),
    );
  }
}


class ImplementListVew extends StatelessWidget {
  const ImplementListVew({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>ImplementingProvider(),
      child: Consumer<ImplementingProvider>(
        builder: (context,provider,child) {
          return provider.isLoading?
          Center(
            child: CustomCircularIndicator(),
          ):
              provider.implementingList.isEmpty?
                  Center(
                    child: Text(
                        "Congratulations, You Had Completed All The Implementing Tasks For Today.",
                      textAlign: TextAlign.center,
                    ),
                  ):
          ListView.builder(
            physics: const BouncingScrollPhysics(),
           itemCount: provider.implementingList.length,
            itemBuilder: (_,index){
              return ImplementingWidget(implementingModel: provider.implementingList[index],);
            },
          );
        }
      ),
    );
  }
}

