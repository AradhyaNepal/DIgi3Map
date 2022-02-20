import 'package:digi3map/screens/domain_list_graph/widget/graph_lable.dart';
import 'package:digi3map/screens/domain_list_graph/widget/graph_single_unit.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class GraphWidget extends StatelessWidget {
  final List<String> xAxisStringList;
  final List<int> yAxisIntList;
  final bool forCoin;
  final int? defaultMin;
  final int units;
  const GraphWidget({
    this.units=5,
    this.defaultMin,
    required this.xAxisStringList,
    required this.yAxisIntList,
    this.forCoin=false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String,int> result=findMinimumMaximum();
    int min=defaultMin??((result[minKey]??0)-10);
    int max=result[maxKey]??0;
    int gap=(max-min)~/units;
    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GraphLable(
                gap: gap,
                max: max,
                min: min,
              ),
              SizedBox(width: 5,),
              Expanded(
                flex: 8,
                child: Row(
                  children: [
                    for (int value in yAxisIntList)
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Expanded(
                                flex:2,
                                child: SingleUnit(
                                  forCoin: forCoin,
                                    graphValueFinal:value
                                )
                            ),
                            const Spacer(),
                          ],
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            const Spacer(flex: 1,),
            Expanded(
              flex: 8,
              child: Row(
                children: [
                  for(int i=0; i<xAxisStringList.length;i++)
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Tooltip(
                              message: xAxisStringList[i] ,
                              child: Text(
                                  xAxisStringList[i],
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: Styles.lightWhiteTextStyle,
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    )
                ],
              ),
            )


          ],
        ),
        const SizedBox(height: 10,),
      ],
    );
  }


  final String minKey="min";
  final String maxKey="max";
  Map<String,int> findMinimumMaximum(){

    int max=0;
    for(int a in yAxisIntList){
      if(a>max){
        max=a;
      }
    }
    int min=max;
    for(int a in yAxisIntList){
      if(a<min){
        min=a;
      }
    }
    return {
      minKey:min,
      maxKey:max
    };
  }
}