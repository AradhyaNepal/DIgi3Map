import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/logo_widget.dart';
import 'package:digi3map/screens/diet/view/diet_page.dart';
import 'package:digi3map/screens/fitness_page/view/fitness_page.dart';
import 'package:digi3map/screens/fitness_page/widgets/fitness_listview.dart';
import 'package:digi3map/screens/habits/view/habit_task_list.dart';
import 'package:digi3map/screens/homepage/provides/random_provider.dart';
import 'package:digi3map/screens/homepage/views/random_task_add_edit.dart';
import 'package:digi3map/screens/homepage/views/random_task_list.dart';
import 'package:digi3map/screens/homepage/widgets/energy_filter_widget.dart';
import 'package:digi3map/screens/homepage/widgets/homepage_drawer.dart';
import 'package:digi3map/screens/study_page/view/study_page.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeTask extends StatefulWidget {
  HomeTask({Key? key}) : super(key: key);

  @override
  State<HomeTask> createState() => _HomeTaskState();
}

class _HomeTaskState extends State<HomeTask> {
  final List<String> headingList=[
    "Diet",
    "Workout",
    "Learning Theory(Ti)",
    "Implementing Practically(Te)",
    "Random Task",
    "Daily Habits"
  ];
  final List<Widget> listViewList=[
    DietListView(),
    FitnessListView(),
    StudyListView(),
    ImplementListVew(),
    RandomTaskList(),
    HabitTaskList(),

  ];
  final List<Widget> pageList=[
    DietPage(),
    FitnessPage(),
    StudyPage(forImplementing: false),
    StudyPage(forImplementing: true),
  ];
  int pageNumber=5;
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context)=>RandomProvider(),
      child: SafeArea(
        child: Scaffold(
          endDrawer: Drawer(child: HomePageDrawer(oldContext: context,)),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 0,
            backgroundColor: Colors.white,
            title:  SizedBox(
                height: 30,
                width: 100,
                child: FittedBox(
                    child: LogoWidget()
                )
            ),
          ),
          body: Container(
            height: size.height,
            width: size.width,
            padding: const EdgeInsets.symmetric(horizontal: Constants.kPaddingValue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "Current Best Task",
                        style: Styles.mediumHeading,
                      ),
                    ),
                    TextButton(
                        onPressed: (){
                          showModalBottomSheet(
                              context: context,
                              builder: (_){
                                return EnergyFilterWidget();
                              }
                          );
                        },
                        child: Text(
                          "Energy Filter"
                        )
                    )
                  ],
                ),
                Divider(color: Colors.black,),
                Expanded(
                  child: SizedBox(
                    width: size.width,
                    child: Column(

                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                  headingList[pageNumber],
                                style: Styles.mediumHeading,
                              ),
                            ),
                            pageNumber!=4 && pageNumber!=5?TextButton(
                                onPressed: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => pageList[pageNumber]));

                                },
                                child: Text(
                                    "Open Page"
                                )
                            ):Spacer()
                          ],
                        ),
                        Constants.kVerySmallBox,
                        Expanded(
                            child:  listViewList[pageNumber],
                        ),
                        Constants.kVerySmallBox,
                        Row(
                          children: [
                            Expanded(
                                child:pageNumber==0?SizedBox(): ElevatedButton(
                                  onPressed: (){
                                    setState(() {
                                      pageNumber--;
                                    });
                                  },
                                  child: Text(
                                    "Previous",
                                    style: Styles.smallHeading,
                                  ),
                                )
                            ),
                            SizedBox(width: 10,),
                            Consumer<RandomProvider>(
                              builder: (context,provider,child) {
                                return ClipOval(
                                  child: InkWell(
                                    splashColor: Colors.red,
                                    onTap: (){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => RandomTaskAddEdit(
                                            provider: provider,
                                          )));
                                    },
                                    child: Container(
                                      color: ColorConstant.kBlueColor,
                                      child: Icon(
                                        Icons.add,
                                        size: 60,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                                child: pageNumber==5?SizedBox():ElevatedButton(
                                  onPressed: (){
                                    setState(() {
                                      pageNumber++;
                                      print(pageNumber);
                                    });
                                  },
                                  child: Text(
                                    "Next",
                                    style: Styles.smallHeading,
                                  ),
                                )
                            ),
                          ],
                        )
                      ],
                    ),
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
