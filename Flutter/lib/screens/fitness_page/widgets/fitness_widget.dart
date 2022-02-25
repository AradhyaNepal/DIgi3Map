import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/selection_collection.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
class FitnessWidget extends StatelessWidget {
  final String name;
  final int number;
  final String image;
  final List<String> musclesTargeted;
  const FitnessWidget({
    required this.name,
    required this.number,
    required this.image,
    required this.musclesTargeted,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        color: ColorConstant.kGreyCardColor,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [

              Expanded(
                  flex: 2,
                  child: Card(
                    margin: EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Image.asset(
                        image
                      ),
                    ),
                  )
              ),
              SizedBox(width: 10,),
              Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                                "$number) $name",
                              style: Styles.mediumHeading,
                            ),
                          ),
                          IconButton(
                              onPressed: (){},
                              icon: Icon(
                                Icons.edit,
                                color: ColorConstant.kIconColor,
                              )
                          )
                        ],
                      ),
                      Constants.kVerySmallBox,
                      Text(
                        "5 Sets (2 min Rest)",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                      Column(
                        children: [
                          for(int i=0;i<5;i++)
                          Text(
                              "40 Kg 7 Rep"
                          ),
                        ],
                      ),
                      Constants.kVerySmallBox,
                      Text(
                        "Targeted Muscle",
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SelectionCollection(valuesList: musclesTargeted),
                      Constants.kVerySmallBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(primary: Colors.red),
                                onPressed: (){},
                                child: Text(
                                  "Skip",
                                  style: Styles.mediumHeading,
                                )
                            ),
                          ),
                          SizedBox(width: 5,),
                          Flexible(
                            child: ElevatedButton(
                                onPressed: (){},
                                child: Text(
                                  "Start",
                                  style: Styles.mediumHeading,
                                )
                            ),
                          ),
                        ],
                      )



                    ],
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }
}
