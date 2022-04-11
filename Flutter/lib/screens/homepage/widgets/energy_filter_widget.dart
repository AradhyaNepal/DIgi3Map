import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/common/widgets/selection_collection.dart';
import 'package:digi3map/screens/homepage/provides/multiplication_provider.dart';
import 'package:digi3map/screens/homepage/provides/selection_notification.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

class EnergyFilterWidget extends StatefulWidget {
  const EnergyFilterWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<EnergyFilterWidget> createState() => _EnergyFilterWidgetState();
}

class _EnergyFilterWidgetState extends State<EnergyFilterWidget> {
  int changedIndex=-1;// Nothing changed
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
          NotificationListener<SelectionNotification>(
            onNotification: (value){
             setState(() {
               changedIndex=value.index;
             });
              return true;
            },
            child: SelectionCollection(
              value: ValueNotifier(""),
                defaultValue: Provider.of<MultiplicationProvider>(context,listen: false).defaultValue,
                valuesList: MultiplicationProvider.energyFilterList
            ),
          ),
          Constants.kSmallBox,
          CustomBlueButton(
              text: "Apply",
              onPressed: (){
                if(changedIndex!=-1){
                  Provider.of<MultiplicationProvider>(context,listen: false).updateIndex(changedIndex);
                }

                Navigator.pop(context);
              }
          ),
        ],
      ),
    );
  }
}
