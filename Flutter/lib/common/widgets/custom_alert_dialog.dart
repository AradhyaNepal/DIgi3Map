
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String heading,subText;
  const CustomAlertDialog({
    required this.heading,
    required this.subText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
          heading,//,
          style:Styles.mediumHeading
      ),
      content: Text(
       subText
      ),
      actions: [
        TextButton(
            onPressed:(){
              Navigator.pop(context,true);//true is value
            },

            child: const Text(
              'Yes',
              style: TextStyle(
                  color: ColorConstant.kBlueColor,
                  fontWeight: FontWeight.w600
              ),
            )
        ),
        TextButton(
            onPressed: (){
              Navigator.pop(context,false);//false is value
            },
            child: Text(
              'No',
              style: TextStyle(
                fontWeight:FontWeight.w600,
                color:Colors.grey.withOpacity(0.5),
              ),
            )
        ),
      ],
    );
  }
}

