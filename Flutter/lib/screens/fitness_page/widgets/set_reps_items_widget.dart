
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/screens/fitness_page/provider/set_rep_changed.dart';
import 'package:digi3map/screens/fitness_page/widgets/rep_weight_rest_editadd.dart';
import 'package:flutter/material.dart';

class SetRepItemsWidget extends StatefulWidget {
  final List<int> values;
  SetRepItemsWidget({
    required this.values,
    Key? key,
  }) : super(key: key);

  @override
  State<SetRepItemsWidget> createState() => _SetRepItemsWidgetState();
}

class _SetRepItemsWidgetState extends State<SetRepItemsWidget> {

  List<int> innerList=[];
  @override
  void initState() {
    super.initState();
    innerList=widget.values;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<SetRepValueChangedNotification>(
      onNotification: (_){
        print("I was here in notification");
        setState(() {

        });
        return true;
      },
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex:2,
                child: RepWeightRestEditAdd(
                  valuesList: innerList,
                  countSets: true,
                  heading: "Sets & Weight",
                ),
              ),
              SizedBox(width: 10,),
              Flexible(
                child: RepWeightRestEditAdd(

                  valuesList: innerList,
                  heading: "Reps",
                ),
              ),
              SizedBox(width: 10,),
              Flexible(
                child: RepWeightRestEditAdd(

                  valuesList: innerList,
                  heading: "Rest Min",
                ),
              ),
            ],
          ),
          (innerList.isEmpty && innerList.length>9)?SizedBox():Constants.kVerySmallBox,
          innerList.length>9?SizedBox():ElevatedButton(
              onPressed: (){
                innerList.add(0);
                setState(() {

                });
              },
              child: Text("New Set")
          )
        ],
      ),
    );
  }
}
