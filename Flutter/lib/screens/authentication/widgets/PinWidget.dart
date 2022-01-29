import 'package:digi3map/screens/authentication/provides/PinValueProvider.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class PinWidget extends StatelessWidget {
  final ValueNotifier<List<String>> pinValue;
  final PinValueProvider pinValueProvider;
  PinWidget({
    required this.pinValue,
    required this.pinValueProvider
  });

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Row(
        children: [
          for(int i=0;i<6;i++)
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: TextField(
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    textInputAction: i<5?TextInputAction.next:TextInputAction.done,
                    decoration: Styles.pinDecoration,
                    obscureText: true,
                    onChanged:(value){
                      pinValueProvider.updateList(i, value);
                    },
                  ),
                )
            ),

        ],
      ),

    );
  }
}

