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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color:Color(0xFF1F54C3) ,width: 1),
        color: isSelected?Color(0xFFE6DBFA):null
      ),
      margin: const EdgeInsets.symmetric(vertical: 4,horizontal: 5),
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      child: Text(
        value,
        style: TextStyle(
          color: Color(0xFF1F54C3),
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
    return 15;
  }
}
