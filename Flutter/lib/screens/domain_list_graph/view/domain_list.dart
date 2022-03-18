import 'package:digi3map/common/collection_widget.dart';
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/screens/domain_crud/provider/domain_provider.dart';
import 'package:digi3map/screens/domain_list_graph/view/domain_graph.dart';
import 'package:digi3map/screens/domain_list_graph/widget/add_domain_list_widget.dart';
import 'package:digi3map/screens/domain_list_graph/widget/carrer_domain_list_widget.dart';
import 'package:digi3map/screens/domain_list_graph/widget/domain_list_intro_widget.dart';
import 'package:digi3map/screens/domain_list_graph/widget/fitness_domain_list_widget.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DomainList extends StatefulWidget {
  const DomainList({Key? key}) : super(key: key);

  @override
  State<DomainList> createState() => _DomainListState();
}

class _DomainListState extends State<DomainList> {
  bool firstTime=true;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>DomainProvider(),
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: Constants.kPagePaddingNoDown,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your 5 Domains',
                  style: Styles.bigHeading,
                ),
                const SizedBox(height: 10,),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Flexible(
                        child: Text(
                          '(Total 100%)',
                          style: Styles.smallHeading,
                        )
                    ),
                    Flexible(
                        child: TextButton(
                          onPressed: (){

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>  DomainGraph()));
                          },
                          child: Text(
                            'Open Graph >>',
                            style: Styles.blueHighlight,
                          ),
                        )
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const FitnessDomainListWidget(),
                        const CareerDomainListWidget(),
                        const SizedBox(height: 10,),
                        Consumer<DomainProvider>(
                            builder: (context,provider,child){
                              if(firstTime){
                                WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                                  provider.getDomainList();
                                });

                                firstTime=false;
                              }
                              List<Domain> domainList=provider.domainList;
                              int itemsLength=domainList.length;
                              int noItemLength=3-itemsLength;
                              return provider.domainLoading?
                              Center(
                                  child: CustomCircularIndicator()
                              ):
                              IconsCollectionWidget(
                                columnNumber: 2,
                                iconsWidgetsList: [
                                  for(Domain domain in domainList)
                                    DomainListIntroWidget(domain: domain,provider: provider,),
                                  for(int i=1;i<=noItemLength;i++)
                                    AddDomainListWidget(provider: provider,)

                                ],
                              );
                            }
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
