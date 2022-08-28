import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/screens/habits/provider/habit_task_provider.dart';
import 'package:digi3map/screens/habits/widgets/habit_task_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserMissionsList extends StatelessWidget {
  const UserMissionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,

      child: ChangeNotifierProvider(
        create:(context)=>HabitTaskProvider() ,
          child: Consumer<HabitTaskProvider>(
            builder: (context,provider,child){
              if(provider.isLoading){
                return Center(
                  child: CustomCircularIndicator(),
                );
              }
              if(provider.currentHabitsList.isEmpty){
                return Center(
                  child: Text(
                    "Congratulation, You Have Completed All Your Habit Tasks",
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return PageView.builder(
                physics: BouncingScrollPhysics(),
                  itemBuilder:(context,index){
                    return HabitTaskWidget(habitModal: provider.currentHabitsList[index]);
                  },
                itemCount: provider.currentHabitsList.length,
              );
            },
          )
      ),
    );
  }
}
