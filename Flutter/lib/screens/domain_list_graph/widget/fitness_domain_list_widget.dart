import 'package:digi3map/common/widgets/selection_unit.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/domain_list_graph/widget/focus_widget.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class FitnessDomainListWidget extends StatelessWidget {
  const FitnessDomainListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.all(8),
        color: ColorConstant.kGreyCardColor,
        width: size.width,
        height: 250,
        child: Row(
          children: [
            Expanded(
              flex: 3,
                child: Column(
                  children:const  [
                    SizedBox(height: 43,),
                    FittedBox(
                      child: Text(
                          'Fitness',
                        textAlign: TextAlign.right,
                        style: Styles.mediumHeading,
                      ),
                    ),
                    Spacer(),
                    FocusWidget(percentage: 26,)

                  ],
                )
            ),
            Expanded(
              flex: 9,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                          AssetsLocation.chadImageLocation
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Column(
                        children:const  [
                          SelectionUnit(isSelected: true,value: 'Diet',),
                          SelectionUnit(isSelected: true,value: "Workout",),
                        ],
                      ),
                    )
                  ],
                )
            ),
            const Spacer(
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}
