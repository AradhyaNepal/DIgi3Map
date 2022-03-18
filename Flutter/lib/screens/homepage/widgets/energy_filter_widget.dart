import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/common/widgets/selection_collection.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class EnergyFilterTestingWidget extends StatelessWidget {
  const EnergyFilterTestingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed:(){
                showModalBottomSheet(
                    context: context,
                    builder: (context){
                      return EnergyFilterWidget();
                    }
                );
              },
                child:const Text('Show Energy Filter')
            ),
          )
      ),
    );
  }
}

class EnergyFilterWidget extends StatelessWidget {
  const EnergyFilterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "How you are feeling",
            style: Styles.bigHeading,
          ),
          Constants.kSmallBox,
          SelectionCollection(
            value: ValueNotifier(""),
              valuesList: [
                'Depressed😭',
                'Stressed😵',
                'Void😐',
                'Happy 😊',
                'Mania😂 '
              ]
          ),
          Constants.kSmallBox,
          CustomBlueButton(
              text: "Apply",
              onPressed: (){
                Navigator.pop(context);
              }
          ),
        ],
      ),
    );
  }
}
