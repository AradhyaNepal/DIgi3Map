import 'package:flutter/material.dart';
enum SelectionUnitSize {small,big}
class SelectionUnit extends StatelessWidget {
  final bool isSelected;
  final String value;
  final SelectionUnitSize selectionUnitSize;
  const SelectionUnit({
    required this.isSelected,
    required this.value,
    this.selectionUnitSize=SelectionUnitSize.small,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isBig=selectionUnitSize==SelectionUnitSize.big;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color:const Color(0xFF1F54C3) ,width: 1),
        color: isSelected?const Color(0xFFE6DBFA):null
      ),
      margin: const EdgeInsets.symmetric(vertical: 4,horizontal: 5),
      padding: EdgeInsets.symmetric(vertical: isBig?10:5,horizontal: isBig?15:10),
      child: Text(
        value,
        style: TextStyle(
          color: const Color(0xFF1F54C3),
          fontWeight: isSelected?FontWeight.bold:null,
          fontSize:getSize()
        ),
      ),
    );
  }

  double getSize(){
    if(selectionUnitSize==SelectionUnitSize.small){
      return 13;
    }
    return 18;
  }
}
