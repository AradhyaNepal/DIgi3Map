import 'package:digi3map/screens/domain_list_graph/widget/graph_lable.dart';
import 'package:digi3map/screens/domain_list_graph/widget/graph_single_unit.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class GraphWidget extends StatelessWidget {
  const GraphWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> domainsName=['Fitness','Career','Commander','Minion','Bunu'];
    final List<int> domainsProgress=[35,25,12,75,23];
    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(
                flex: 1,
                child: GraphLable(),
              ),
              Expanded(
                flex: 8,
                child: Row(
                  children: [
                    for (int value in domainsProgress)
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Expanded(
                                flex:2,
                                child: SingleUnit(graphValueFinal:value)
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
                  for(int i=0; i<domainsName.length;i++)
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Tooltip(
                              message: domainsName[i] ,
                              child: Text(
                                  domainsName[i],
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
}