import 'package:digi3map/common/widgets/selection_unit.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/domain_list_graph/widget/focus_widget.dart';
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
                  children: const [
                    FittedBox(
                      child: Text(
                          'Career',
                        style: Styles.mediumHeading,
                      ),
                    ),
                    FocusWidget(percentage: 40,)
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
                      children:const  [
                        SelectionUnit(isSelected: true, value: "FYP UI"),
                        SelectionUnit(isSelected: true, value: "Dart Binge"),
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
