import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/logo_widget.dart';
import 'package:digi3map/screens/diet/view/diet_page.dart';
import 'package:digi3map/screens/domain_crud/provider/domain_provider.dart';
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


class UserMissions extends StatefulWidget {
  UserMissions({Key? key}) : super(key: key);

  @override
  State<UserMissions> createState() => _UserMissionsState();
}

class _UserMissionsState extends State<UserMissions> {
  final List<String> headingList=[];
  final List<Widget> listViewList=[];
  final List<Widget> pageList=[];
  int pageNumber=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUpList();
  }
  bool isLoading=true;
  void setUpList() async{
    FitnessCareerPoints points=await DomainProvider().getFitnessCareerPoints();
    headingList.add("Custom Habits");
    listViewList.add(UserMissionsList());
    pageList.add(SizedBox());
    if(points.careerPoints>points.fitnessPoint){
      //That means fitness is less focused
      addFitness();
      addCareer();
    }else{
      //That means career is less focused
      addCareer();
      addFitness();
    }
    headingList.add("Random Task");
    listViewList.add(RandomTaskList());
    pageList.add(SizedBox());
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {
        isLoading=false;
      });
    });

  }
  void addFitness(){
    headingList.add("Workout",);
    listViewList.add(FitnessListView(fromHome: true,));
    pageList.add(FitnessPage());

    headingList.add("Diet");
    listViewList.add(DietListView(fromHome: true,));
    pageList.add(DietPage());
  }
  void addCareer(){
    headingList.add("Implement Practically(Te)",);
    listViewList.add(ImplementListVew(fromHomePage: true,));
    pageList.add(StudyPage(forImplementing: true));

    headingList.add("Learning Theory(Ti)",);
    listViewList.add(StudyListView(fromHomePage: true,));
    pageList.add(StudyPage(forImplementing: false));
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context)=>RandomProvider(),
      child: SafeArea(
        child: Scaffold(

          body: Container(
            height: size.height,
            width: size.width,
            padding: const EdgeInsets.symmetric(horizontal: Constants.kPaddingValue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Constants.kSmallBox,
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
                    child: isLoading?
                    Center(
                      child: CustomCircularIndicator(),
                    ):Column(

                      children: [
                        SizedBox(height: pageNumber==0 || pageNumber==
                            5?10:0,),
                        Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [

                            Flexible(
                              child: Text(
                                  headingList[pageNumber],
                                style: Styles.semiMedium,
                              ),
                            ),
                            pageNumber!=0 && pageNumber!=5?TextButton(
                                onPressed: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => pageList[pageNumber]));

                                },
                                child: Text(
                                    "Open Page"
                                )
                            ):SizedBox()
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
