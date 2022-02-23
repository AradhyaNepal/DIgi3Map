
import 'package:digi3map/screens/homepage/widgets/energy_filter_widget.dart';
import 'package:flutter/material.dart';

class DietHeaderWidget extends StatelessWidget {
  const DietHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Flexible(
            flex: 3,
            child: TextButton(
              onPressed: (){

              },
              child: Text(
                  "Customize Body Details"
              ),
            )
        ),
        SizedBox(width: 5,),
        Flexible(
            flex: 2,
            child: TextButton(
              onPressed: (){
                showModalBottomSheet(
                    context: context,
                    builder: (context){
                      return EnergyFilterWidget();
                    }
                );
              },
              child: Text(
                  "Energy Filter"
              ),
            )
        ),
      ],
    );
  }
}
