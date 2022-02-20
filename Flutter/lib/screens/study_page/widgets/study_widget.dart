
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class StudyWidget extends StatelessWidget {
  final int number;
  const StudyWidget({
    required this.number,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
      child: Card(
        elevation: 5,
        color: ColorConstant.kGreyCardColor,
        margin: const EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Card(
                      margin: const EdgeInsets.all(0),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Image.asset(
                          AssetsLocation.studyDummyLocation,
                        ),
                      ),
                    ) ,
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'NOS Course Work',
                          style: Styles.mediumHeading,
                        ),
                        Constants.kVerySmallBox,
                        Text(
                          '3 Sets (2 Min Rest)',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline
                          ),
                        ),
                        Text(
                            "Set 1: 20 min Study"
                        ),
                        Text(
                            "Set 2: 30 min Study"
                        ),
                        Text(
                            "Set 3: 40 min Study"
                        ),
                        Constants.kVerySmallBox,
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: ColorConstant.kBlueColor),
                            onPressed: (){},
                            child: Text("Start")
                        )
                      ],
                    ),
                  ),
                  Spacer()
                ],
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Text(
                  "$number)",
                  style: Styles.bigHeading,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child:  IconButton(
                  onPressed: (){},
                  icon: Icon(
                    Icons.edit,
                    color: ColorConstant.kIconColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
