import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/graph_time_widget.dart';
import 'package:digi3map/screens/domain_list_graph/provider/domain_graph_provider.dart';
import 'package:digi3map/screens/domain_list_graph/widget/graph_index.dart';
import 'package:digi3map/screens/domain_list_graph/widget/graph_widget.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class DomainGraph extends StatelessWidget {
  const DomainGraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          padding: Constants.kPagePadding,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Domain Balance Graph",
                  style: Styles.bigHeading,
                ),
                Constants.kSmallBox,
                const GraphTimeFrame(),
                Constants.kSmallBox,
                Container(
                  height: 500,
                  width: size.width,
                  padding: const EdgeInsets.all(10),
                  color: ColorConstant.kLightBlackColor,
                  child: Column(
                    children: [
                      GraphIndex(),
                      Expanded(
                        child: FutureBuilder<DomainGraphModel>(
                          future: DomainGraphProvider().getDomainGraph(),
                          builder: (context,snapShot) {
                            if(snapShot.connectionState==ConnectionState.waiting){
                              return Center(
                                child: CustomCircularIndicator(),
                              );
                            }
                            DomainGraphModel domainGraph=snapShot.data??DomainGraphModel(xAxis: ["0"], yAxis: [0]);
                            return GraphWidget(
                              defaultMin: 0,
                              xAxisStringList:domainGraph.xAxis,
                              yAxisIntList: domainGraph.yAxis,
                            );
                          }
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  

}




