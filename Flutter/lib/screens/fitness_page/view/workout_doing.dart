import 'package:digi3map/common/constants.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class WorkoutDoing extends StatelessWidget {
  const WorkoutDoing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          padding: Constants.kPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Deadlift",
                style: Styles.bigHeading,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Constants.kMediumBox,
                      SizedBox(
                        width: 250,
                        height: 250,
                        child: Image.asset(
                            AssetsLocation.deadLiftImageLocation
                        ),
                      ),
                      Text(
                        "40 KG 7 Rep",
                        style: Styles.bigHeading,
                      ),
                      SizedBox(height: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Text(
                                "Tips:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              )
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            flex: 5,
                              child: Text(
                                  "Its not about how heavy you lift, its about whether you lift EVERY SIGNLE DAY ",
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                              ),

                          ),
                        ],
                      ),
                      Constants.kMediumBox,
                      Text(
                        "Timer: 02:00",
                        style: Styles.bigHeading,
                      ),
                      Constants.kMediumBox,
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Next 5 min rest",
                  style: Styles.mediumHeading,
                ),
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                        onPressed: (){},
                        child: Text(
                          "Failed",
                          style: Styles.mediumHeading,
                        )
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: (){},
                        child: Text(
                          "Completed",
                          style: Styles.mediumHeading,
                        )
                    ),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
