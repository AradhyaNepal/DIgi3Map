import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/selection_unit.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/domain_crud/provider/domain_provider.dart';
import 'package:digi3map/screens/domain_crud/view/domain_view_edit_delete.dart';
import 'package:digi3map/screens/domain_list_graph/view/domain_graph.dart';
import 'package:digi3map/screens/domain_list_graph/widget/focus_widget.dart';
import 'package:digi3map/screens/habits/view/habits_read_delete_update.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                  children:  [
                    SizedBox(height: 43,),
                    FittedBox(
                      child: Text(
                          'Fitness',
                        textAlign: TextAlign.right,
                        style: Styles.mediumHeading,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: (){

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>  DomainGraph()));
                      },
                      child: Consumer<DomainProvider>(
                        builder: (context,provider,child) {
                          if(provider.domainLoading){
                            return Center(
                              child: CustomCircularIndicator(),
                            );
                          }
                          return FocusWidget(
                            percentage: provider.points.fitnessPoint,
                          );
                        }
                      ),
                    )

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
                        children:  [
                          SelectionUnit(
                            isSelected: true,
                            value: 'Diet',
                          ),
                          SelectionUnit(
                            isSelected: true,
                            value: "Workout",
                          ),
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
