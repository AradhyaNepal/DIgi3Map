
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/screens/fitness_page/provider/set_rep_changed.dart';
import 'package:digi3map/screens/fitness_page/widgets/editable_text_widget.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class RepWeightRestEditAdd extends StatelessWidget {
  final List<int> valuesList;
  final String heading,unit;
  final bool countSets;

  RepWeightRestEditAdd({
    required this.valuesList,
    this.countSets=false,
    required this.heading,
    this.unit="",
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        valuesList.isEmpty?SizedBox():FittedBox(
          child: Text(
            heading,
            style: Styles.opacityHeadingStyle,
          ),
        ),
        valuesList.isEmpty?SizedBox():Constants.kSmallBox,
        for(int i=0;i<valuesList.length;i++)
          Row(
            children: [
              countSets?
              Flexible(
                child: Row(
                  children: [
                    Flexible(
                      child: FittedBox(
                        child: Text(
                            "${i+1}: "
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Flexible(
                      child: IconButton(
                        onPressed: (){
                          valuesList.removeAt(i);
                          print(valuesList.toString());
                          SetRepValueChangedNotification().dispatch(context);

                        },
                        icon: Icon(
                          Icons.delete,
                          color: ColorConstant.kIconColor,
                        ),
                      ),
                    )

                  ],
                ),
              )
                  :SizedBox(),
              SizedBox(width: countSets?10:0,),
              Flexible(
                child: EditableTextWidget(
                  key: ValueKey(valuesList[i]),
                    defaultValue: valuesList[i].toString(),
                    unit: unit
                ),
              ),
            ],
          )
      ],
    );
  }
}


