
import 'package:digi3map/screens/habit_milestone_graph_chain/widgets/single_chain_widget.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:flutter/material.dart';

class MultipleChainWidget extends StatelessWidget {
  final int chainNumber;
  const MultipleChainWidget({
    required this.chainNumber,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Card(
      margin: const EdgeInsets.all(0),
      color: ColorConstant.kGreyCardColor,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: size.width,
        height: 200,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for(int i=1;i<=chainNumber;i++)
                Transform.translate(
                  offset:Offset(
                      i!=1?
                      (i-1)*-50:0,
                      0
                  ),
                  child: SingleChainWidget(
                    dayNumber: i,
                  ),
                ),
              chainNumber>4?Icon(
                Icons.arrow_back,
                size: 50,
              ):SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
