import 'package:digi3map/common/constants.dart';
import 'package:digi3map/data/models/diet_model.dart';
import 'package:digi3map/screens/diet/widgets/diet_header_widget.dart';
import 'package:digi3map/screens/diet/widgets/diet_widget.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class DietPage extends StatelessWidget {
  const DietPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          padding: Constants.kPagePaddingNoDown,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Diet",
                style: Styles.bigHeading,
              ),
              Constants.kSmallBox,
              DietHeaderWidget(),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    for(int i=0;i<DietData.dietData.length;i++)
                    DietWidget(diet: DietData.dietData[i],)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
