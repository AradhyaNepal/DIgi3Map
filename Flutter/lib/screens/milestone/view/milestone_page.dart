import 'dart:math';

import 'package:digi3map/common/constants.dart';
import 'package:digi3map/data/services/assets_location.dart';
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MileStoneWidget extends StatelessWidget {
  final int progressValue;
  const MileStoneWidget({
    required this.progressValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int progress=progressValue;
    int maxLimit=100;
    if(progress>100) progress=100;
    return Container(
      height: 125,
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
                flex: 3,
                  child: Image.asset(
                      AssetsLocation.mileStoneDummyLocation
                  )
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 9,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Workout",
                          style: Styles.mediumHeading,
                        ),
                        Spacer(flex: 2,),
                        Text(
                            "Spend total 10 hour",
                            style:Styles.smallHeading
                        ),
                        Constants.kVerySmallBox,
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
                        Spacer(flex: 4,),


                      ],
                    ),
                  )
              ),
              SizedBox(width: 10,),
              Expanded(
                flex: 2,
                  child: FittedBox(
                      child: Column(
                        children: [
                          CoinValueWidget(
                            value: 10,
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
    );
  }
}

class TotalCoinsWidget extends StatelessWidget {
  const TotalCoinsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Points\nCollected",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(width: 10,),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4)
          ),
          child: CoinValueWidget(value:50,),
        )

      ],
    );
  }
}

class CoinValueWidget extends StatelessWidget {
  final int value;
  const CoinValueWidget({
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          AssetsLocation.coinIconLocation,
          height: 40,
          width: 40,
        ),
        SizedBox(width: 4,),
        Text(
          "✖",
          style: TextStyle(
              fontSize: 10
          ),
        ),
        Text(
          value.toString(),
          style: Styles.bigHeading,
        )
      ],
    );
  }
}


