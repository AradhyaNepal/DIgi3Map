import 'package:digi3map/common/widgets/selection_unit.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/domain_crud/view/domain_view_edit_delete.dart';
import 'package:digi3map/screens/domain_list_graph/view/domain_graph.dart';
import 'package:digi3map/screens/domain_list_graph/widget/focus_widget.dart';
import 'package:digi3map/screens/habits/view/habits_read_delete_update.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class CareerDomainListWidget extends StatelessWidget {
  const CareerDomainListWidget({Key? key}) : super(key: key);

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
        height: 200,
        child: Row(
          children: [
            Expanded(
              flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                      child: Text(
                          'Career',
                        style: Styles.mediumHeading,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>  DomainGraph()));
                      },
                      child: FocusWidget(
                        percentage: 40,
                      ),
                    )
                  ],
                )
            ),
            Expanded(
              flex: 9,
                child: Column(
                  children: [
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.asset(
                              AssetsLocation.anonymousImageLocation,
                            fit: BoxFit.fill,
                          ),
                        )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>  HabitsReadDeleteUpdate()));
                          },
                          child: SelectionUnit(
                              isSelected: true,
                              value: "FYP UI"
                          ),
                        ),
                        GestureDetector(
                          onTap: (){

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>  HabitsReadDeleteUpdate()));
                          },
                          child: SelectionUnit(
                              isSelected: true,
                              value: "Dart Binge"
                          ),
                        ),
                      ],
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
