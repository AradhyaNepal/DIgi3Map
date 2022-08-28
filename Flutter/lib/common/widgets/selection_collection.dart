import 'package:digi3map/common/widgets/selection_unit.dart';
import 'package:digi3map/screens/homepage/provides/selection_notification.dart';
import 'package:flutter/material.dart';

class SelectionCollection extends StatefulWidget {
  final List<String> valuesList;
  final bool unSelectable;
  final ValueNotifier<String> value;
  final String? defaultValue;
  const SelectionCollection({
    required this.valuesList,
    required this.value,
    this.defaultValue,
    this.unSelectable=false,
    Key? key
  }) : super(key: key);

  @override
  _SelectionCollectionState createState() => _SelectionCollectionState();
}

class _SelectionCollectionState extends State<SelectionCollection> {

  int selectedIndex=0;

  @override
  void initState() {
    widget.value.value=widget.valuesList[selectedIndex];
    selectedIndex=widget.valuesList.indexWhere((element) => element==widget.defaultValue);
    if(selectedIndex==-1) selectedIndex=0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for(int i=0;i<widget.valuesList.length;i++)
          GestureDetector(
            onTap: (){
              setState(() {
                if(selectedIndex==i && widget.unSelectable){
                  selectedIndex=-1;
                }
                else{
                  selectedIndex=i;
                  widget.value.value=widget.valuesList[selectedIndex];
                }

              });
              SelectionNotification(index: selectedIndex).dispatch(context);
            },
              child: SelectionUnit(
                selectionUnitSize: SelectionUnitSize.big,
                  isSelected: selectedIndex==i,
                  value: widget.valuesList[i]
              )
          )
      ],
    );
  }
}
