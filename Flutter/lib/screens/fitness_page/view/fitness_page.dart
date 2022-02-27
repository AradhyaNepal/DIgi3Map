import 'package:digi3map/common/constants.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/fitness_page/widgets/fitness_listview.dart';
import 'package:digi3map/screens/fitness_page/widgets/fitness_widget.dart';
import 'package:digi3map/screens/homepage/widgets/energy_filter_widget.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FitnessPage extends StatelessWidget {
  const FitnessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButton:FloatingActionButton(
          onPressed: () {  },
          child:Icon(Icons.add,color: Colors.white,)
        ),
        body: Container(
          height: size.height,
          width: size.width,
          padding: Constants.kPagePaddingNoDown,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Fitness",
                style: Styles.bigHeading,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Flexible(
                    child: Text(
                      "Your Today Workout (20 Set)",
                      style: Styles.smallHeading,
                    ),
                  ),
                  SizedBox(width: 10,),
                  TextButton(
                      onPressed: (){
                        showModalBottomSheet(
                            builder: (_) {
                              return EnergyFilterWidget();
                            },
                            context: context
                        );
                      },
                      child: Text(
                        "Energy Filter"
                      )
                  )
                ],
              ),
              Constants.kSmallBox,
              Expanded(
                child:FitnessListView() ,
              )
            ],
          ),
        ),
      ),
    );
  }
}
