import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/screens/fitness_page/provider/fitness_provider.dart';
import 'package:digi3map/screens/fitness_page/widgets/fitness_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FitnessListView extends StatelessWidget {
  final bool fromHome;
  const FitnessListView({
    this.fromHome=false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>RandomProvider(),
      child: Consumer<RandomProvider>(
        builder: (context,provider,child) {
          return provider.isLoading?
          Center(child: CustomCircularIndicator()):
              provider.fitnessList.isEmpty?
                  Center(
                    child:Text(
                        "Congratulation You Have Completed All Fitness Task",
                      textAlign: TextAlign.center,
                    )
                  ):
                  fromHome?
                  PageView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder:(context,index){
                     return FittedBox(
                       child: FitnessWidget(
                           fitnessModel: provider.fitnessList[index]
                       ),
                     );

                    },
                    itemCount: provider.fitnessList.length,
                  )
                      :
          ListView.builder(
            physics: BouncingScrollPhysics(),
              itemBuilder:(context,index){
                return FitnessWidget(fitnessModel: provider.fitnessList[index]);
              },
            itemCount: provider.fitnessList.length,
          );
        }
      ),
    );
  }
}
