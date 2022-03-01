
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/fitness_page/widgets/fitness_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FitnessListView extends StatelessWidget {
  const FitnessListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        for(int i=1;i<11;i++)
          i%2==0?
          FitnessWidget(
            number: i,
            name: 'Deadlift',
            musclesTargeted: [
              'Hams',
              'Glutes',
              'Core',
              'Back'
            ],
            image: AssetsLocation.deadLiftImageLocation,

          ):
          FitnessWidget(
            number: i,
            name: 'Calf',
            musclesTargeted: [
              'Calf'
            ],
            image: AssetsLocation.calfImageLocation,
          )
      ],
    );
  }
}
