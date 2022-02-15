import 'package:digi3map/common/constants.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final ValueNotifier<String?> valueNotifier;
  final FocusNode nextNode;
  const CustomTextfield({
    required this.valueNotifier,
    required this.nextNode,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Expanded(
                flex: 1,
                child: Icon(Icons.person_outline_rounded,color: ColorConstant.kIconColor,)
            ),
            Constants.kSmallBox,
            Expanded(
              flex: 9,
              child: TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value)=>valueNotifier.value=value,
                  onFieldSubmitted: (value){
                    FocusScope.of(context).requestFocus(nextNode);
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please Enter Email";
                    }
                    return null;
                  },
                  decoration: Styles.getSimpleInputDecoration("Email Address")
              ),
            ),
          ],
        ),
      ),
    );
  }
}
