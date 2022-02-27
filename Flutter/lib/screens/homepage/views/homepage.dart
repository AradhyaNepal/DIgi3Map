import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/logo_widget.dart';
import 'package:digi3map/screens/fitness_page/widgets/fitness_listview.dart';
import 'package:digi3map/screens/homepage/widgets/energy_filter_widget.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {  },
          child: Icon(
              Icons.add,
            color: Colors.white,
          ),
        ),
        body: Container(
          height: size.height,
          width: size.width,
          color: ColorConstant.kGreyCardColor,
          padding: Constants.kPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
                  width: 100,
                  child: FittedBox(
                      child: LogoWidget()
                  )
              ),
              Constants.kVerySmallBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "Current Best Task",
                      style: Styles.mediumHeading,
                    ),
                  ),
                  TextButton(
                      onPressed: (){
                        showModalBottomSheet(
                            context: context,
                            builder: (_){
                              return EnergyFilterWidget();
                            }
                        );
                      },
                      child: Text(
                        "Energy Filter"
                      )
                  )
                ],
              ),
              Constants.kVerySmallBox,
              Expanded(
                child: SizedBox(
                  width: size.width,
                  child: Card(
                    margin: const EdgeInsets.all(0),
                    child:Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(

                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                    "Workout",
                                  style: Styles.mediumHeading,
                                ),
                              ),
                              TextButton(
                                  onPressed: (){},
                                  child: Text(
                                      "Open Page"
                                  )
                              )
                            ],
                          ),
                          Constants.kVerySmallBox,
                          Expanded(
                              child: FitnessListView()
                          ),
                          Constants.kVerySmallBox,
                          Row(
                            children: [
                              Expanded(
                                  child: ElevatedButton(
                                    onPressed: (){},
                                    child: Text(
                                      "Previous",
                                      style: Styles.smallHeading,
                                    ),
                                  )
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                  child: ElevatedButton(
                                    onPressed: (){},
                                    child: Text(
                                      "Next",
                                      style: Styles.smallHeading,
                                    ),
                                  )
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
