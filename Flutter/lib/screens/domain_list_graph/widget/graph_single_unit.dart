import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SingleUnit extends StatelessWidget {
  final bool forCoin;
  const SingleUnit({
    required this.forCoin,
    Key? key,
    required this.graphValueFinal,
  }) : super(key: key);

  final int graphValueFinal;


  @override
  Widget build(BuildContext context) {
    int graphValue=graphValueFinal;
    int totalValue=101;
    if(graphValue>100) graphValue=100;
    if(graphValue<0) graphValue=0;
    bool isBalanced=(graphValue>=20 && graphValue<=30)||forCoin;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Spacer(flex: totalValue-graphValue,),
        Expanded(
          flex: graphValue,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: isBalanced?
                    ColorConstant.kLightGreenColor:
                    ColorConstant.kLightRedColor,
                    borderRadius: BorderRadius.circular(5)
                  ),

                ),
              ),
              Positioned.fill(
                  child: Center(
                    child: forCoin?SizedBox():isBalanced?SvgPicture.asset(AssetsLocation.tickIconLocation):const Icon(Icons.close,color: Colors.red,),
                  )
              )
            ],
          ),
        ),

      ],
    );
  }
}
