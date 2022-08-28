import 'package:digi3map/screens/authentication/provides/pin_value_provider.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class PinWidget extends StatelessWidget {
  final ValueNotifier<List<String>> pinValue;
  const PinWidget({
    required this.pinValue,
    Key? key
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    final pinValueProvider=Provider.of<PinValueProvider>(context,listen: false);
    return SizedBox(
      width: size.width,
      child: Row(
        children: [
          for(int i=0;i<6;i++)
            Expanded(
                child:  PinUnit(i: i, pinValueProvider: pinValueProvider)
            ),

        ],
      ),

    );
  }
}

class PinUnit extends StatefulWidget {

  const PinUnit({
    Key? key,
    required this.i,
    required this.pinValueProvider,
  }) : super(key: key);

  final int i;
  final PinValueProvider pinValueProvider;

  @override
  State<PinUnit> createState() => _PinUnitState();
}

class _PinUnitState extends State<PinUnit> {
  final TextEditingController _controller=TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: TextField(
        controller: _controller,
        onTap: (){
          print("Pressed");
          _controller.text="";
        },
        maxLength: 1,
        textAlign: TextAlign.center,
        textInputAction: widget.i<5?TextInputAction.next:TextInputAction.done,
        decoration: Styles.pinDecoration,
        onChanged:(value){

          widget.pinValueProvider.updateList(widget.i, value);
          if(value.length==1) FocusScope.of(context).nextFocus();
        },
      ),
    );
  }
}



