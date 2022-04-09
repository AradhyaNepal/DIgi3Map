import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/screens/homepage/provides/random_provider.dart';
import 'package:digi3map/screens/homepage/views/random_task_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RandomTaskList extends StatelessWidget {
  const RandomTaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RandomProvider>(
      builder: (context,provider,child) {
        return provider.isLoading?
        Center(
          child: CustomCircularIndicator(),
        ):
            provider.randomList.isEmpty?
                Center(
                  child: Text(
                      "Congratulation, You Have Completed All Your Random Task",
                    textAlign: TextAlign.center,
                  ),
                ):
        ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context,index){
            return RandomTaskWidget(
              randomTaskModal: provider.randomList[index],
            );
          },
          itemCount: provider.randomList.length,
        );
      }
    );
  }
}
