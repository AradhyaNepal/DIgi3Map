import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/provider/milestone_provider.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/widgets/milestone_widget.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/widgets/total_coins_widget.dart';
import 'package:digi3map/screens/habits/view/habits_create.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MileStonePage extends StatefulWidget {
  const MileStonePage({Key? key}) : super(key: key);

  @override
  State<MileStonePage> createState() => _MileStonePageState();
}

class _MileStonePageState extends State<MileStonePage> {
  bool firstTime=true;
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context)=>MileStoneProvider(),
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: Consumer<MileStoneProvider>(
            builder: (context,provider,child) {
              return FloatingActionButton(
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  AddHabits())).then((value) {
                        provider.getMilestones();
                  });
                },
                child: const Icon(
                    Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
              );
            }
          ),
          body: Container(
            height: size.height,
            width: size.width,
            padding: Constants.kPagePaddingNoDown,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Habits Milestone',
                  style: Styles.bigHeading,
                ),
                Consumer<MileStoneProvider>(
                  builder: (context,provider,child) {
                    return TotalCoinsWidget(
                      point: provider.points,
                    );
                  }
                ),
                Constants.kSmallBox,
                Expanded(
                  child: Consumer<MileStoneProvider>(
                    builder: (context,provider,child) {
                      if(firstTime){
                        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                          provider.getMilestones();
                          firstTime=false;
                        });
                      }
                      if(provider.isLoading){
                        return const Center(
                          child: CustomCircularIndicator(),
                        );
                      }
                      return ListView.builder(
                        itemCount: provider.milestoneList.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context,i){
                          bool isLast=i==(provider.milestoneList.length-1);
                          Widget widget;
                          if(isLast){
                            widget=Column(
                              children: [
                                MileStoneWidget(
                                    mileStone: provider.milestoneList[i],
                                  provider: provider,
                                ),
                                SizedBox(height: 40,)
                              ],
                            );
                          }
                          else{
                            widget=MileStoneWidget(
                                mileStone: provider.milestoneList[i],
                              provider: provider,
                            );
                          }
                          return widget;
                        },
                      );
                    }
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