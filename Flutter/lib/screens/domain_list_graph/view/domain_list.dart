import 'package:digi3map/common/constants.dart';
import 'package:digi3map/screens/domain_list_graph/widget/add_domain_list_widget.dart';
import 'package:digi3map/screens/domain_list_graph/widget/carrer_domain_list_widget.dart';
import 'package:digi3map/screens/domain_list_graph/widget/domain_list_intro_widget.dart';
import 'package:digi3map/screens/domain_list_graph/widget/fitness_domain_list_widget.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class DomainList extends StatelessWidget {
  const DomainList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: Constants.kPagePaddingNoDown,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                    'Your 5 Domains',
                  style: Styles.bigHeading,
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: const [
                    Flexible(
                        child: Text(
                            '(Total 100%)',
                          style: Styles.smallHeading,
                        )
                    ),
                    Flexible(
                        child: Text(
                            'Open Graph >>',
                          style: Styles.blueHighlight,
                        )
                    ),
                  ],
                ),
                const FitnessDomainListWidget(),
                const CareerDomainListWidget(),
                const SizedBox(height: 10,),
                Row(
                  children: const [
                    Expanded(
                      child: DomainListIntroWidget()
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: AddDomainListWidget()
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: AddDomainListWidget()
                    ),
                    SizedBox(width: 5,),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
