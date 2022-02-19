import 'package:digi3map/common/constants.dart';
import 'package:digi3map/screens/domain_list_graph/widget/graph_index.dart';
import 'package:digi3map/screens/domain_list_graph/widget/graph_widget.dart';
import 'package:digi3map/screens/domain_list_graph/widget/time_filter_widget.dart';
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Time Frame',
                      style: Styles.smallHeading,
                    ),
                    Constants.kVerySmallBox,
                    TextButton(
                        onPressed: (){
                          showModalBottomSheet(
                            isScrollControlled: true,
                              context: context,
                              builder: (context){
                                return const TimeFilterWidget();
                              }
                          );
                        },
                        child: const Text(
                            'Filter',
                          style: Styles.blueHighlight,
                        )
                    )
                  ],
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '11/11/2021 - 11/12/2022',
                    style: Styles.smallHeading,
                  ),
                ),
                Constants.kSmallBox,
                Container(
                  height: 500,
                  width: size.width,
                  color: ColorConstant.kLightBlackColor,
                  child: Column(
                    children: const [
                      GraphIndex(),
                      Expanded(
                        child: GraphWidget(),
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







