
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/domain_list_graph/widget/time_filter_widget.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Monthly Score:",
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(width: 5,),
        Text(
          "500",
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(width: 5,),
        SvgPicture.asset(
          AssetsLocation.coinIconLocation,
          height: 20,
          width: 20,
        ),
        TextButton(
            onPressed: (){
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context){
                    return TimeFilterWidget();
                  }
              );
            },
            child: Text(
              'Filter',
              style: Styles.blueHighlight,
            )
        )

      ],
    );
  }
}
