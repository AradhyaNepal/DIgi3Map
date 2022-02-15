import 'package:digi3map/common/constants.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class PasswordForm extends StatefulWidget {
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final ValueNotifier<String?> valueProvider;
  final String heading;
  const PasswordForm({
    this.focusNode,
    required this.valueProvider,
    this.nextNode,
    required this.heading,
    Key? key
  }) : super(key: key);

  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {

  bool _isVisible=false;
  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 3,

      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Expanded(
                flex: 1,
                child: Icon(
                  Icons.lock_outline_rounded,
                  color: ColorConstant.kIconColor,
                )
            ),
            Constants.kSmallBox,
            Expanded(
              flex:8,
              child: TextFormField(
                focusNode: widget.focusNode,
                textInputAction: widget.nextNode!=null?TextInputAction.next:TextInputAction.done,
                onFieldSubmitted: (value){
                  if(widget.nextNode!=null) FocusScope.of(context).requestFocus(widget.nextNode);
                },
                onSaved: (value)=>widget.valueProvider.value=value,
                validator: (value){
                  if(value!.isEmpty) return "Please Enter ${widget.heading}";
                  return null;
                },
                obscureText: !_isVisible,
                decoration: Styles.getSimpleInputDecoration(widget.heading),
              ),
            ),
            Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: (){
                    setState(() {
                      _isVisible=!_isVisible;
                    });
                  },
                  icon: Icon(
                    _isVisible?Icons.visibility_off_outlined:Icons.visibility_outlined,
                    color: ColorConstant.kIconColor,
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}

