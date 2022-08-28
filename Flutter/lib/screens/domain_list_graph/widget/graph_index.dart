import 'package:digi3map/common/constants.dart';
import 'package:digi3map/screens/domain_list_graph/widget/index_widget.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:flutter/material.dart';

class GraphIndex extends StatelessWidget {
  const GraphIndex({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:const  [
            Constants.kVerySmallBox,
            IndexUnit(balancedDetail: true,),
            Constants.kVerySmallBox,
            IndexUnit(balancedDetail: false,),
            Constants.kVerySmallBox,
          ],
        ),
      ],
    );
  }
}
