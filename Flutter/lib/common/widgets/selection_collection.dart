import 'package:digi3map/common/widgets/selection_unit.dart';
import 'package:flutter/material.dart';

class SelectionCollection extends StatefulWidget {
  final List<String> valuesList;
  const SelectionCollection({
    required this.valuesList,
    Key? key
  }) : super(key: key);

  @override
  _SelectionCollectionState createState() => _SelectionCollectionState();
}

class _SelectionCollectionState extends State<SelectionCollection> {
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for(int i=0;i<widget.valuesList.length;i++)
          GestureDetector(
            onTap: (){
              setState(() {
                selectedIndex=i;
              });
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
