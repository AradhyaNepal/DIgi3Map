import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/screens/diet/provider/diet_provider.dart';
import 'package:digi3map/screens/diet/widgets/diet_header_widget.dart';
import 'package:digi3map/screens/diet/widgets/diet_widget.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DietPage extends StatelessWidget {
  const DietPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          padding: Constants.kPagePaddingNoDown,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Diet",
                style: Styles.bigHeading,
              ),
              Constants.kSmallBox,
              DietHeaderWidget(),
              Expanded(
                child: DietListView(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DietListView extends StatelessWidget {
  const DietListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>DietProvider(),
      child: Consumer<DietProvider>(
        builder: (context,provider,child) {
          return provider.isLoading?
          Center(
            child: CustomCircularIndicator(),
          ):
              provider.dietData.isEmpty?
                  Center(
                    child: Text(
                        "Congratulation You Had Completed All Today's Diet Task",
                      textAlign: TextAlign.center,
                    ),
                  ):
          ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: provider.dietData.length,
            itemBuilder: (context,index){
              return DietWidget(diet: provider.dietData[index]);
            },
          );
        }
      ),
    );
  }
}
