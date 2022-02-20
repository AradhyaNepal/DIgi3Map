
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/screens/domain_list_graph/widget/time_filter_widget.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class GraphTimeFrame extends StatelessWidget {
  const GraphTimeFrame({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              'Time Frame',
              style: Styles.smallHeading,
            ),
            Constants.kVerySmallBox,
            TextButton(
                onPressed: (){
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context){
                        return const TimeFilterWidget();
                      }
                  );
                },
                child: const Text(
                  'Filter',
                  style: Styles.blueHighlight,
                )
            )
          ],
        ),

        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            '11/11/2021 - 11/12/2022',
            style: Styles.smallHeading,
          ),
        ),
      ],
    );
  }
}



