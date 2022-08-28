import 'package:digi3map/screens/domain_list_graph/view/domain_list.dart';
import 'package:digi3map/screens/group_portle/view/leaderboard_group.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/view/milestone_page.dart';
import 'package:digi3map/screens/homepage/views/user_missions.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentPage = 0;
  List<Widget> screens = [
    UserMissions(),
    DomainList(),
    MileStonePage(),
    LeaderboardInGroup(),

  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: screens[_currentPage],
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: _currentPage,
          backgroundColor: Colors.white,

          type: BottomNavigationBarType.fixed,
          selectedItemColor: ColorConstant.kBlueColor,
          unselectedItemColor: Colors.grey.withOpacity(0.6),
          selectedFontSize: 11,
          unselectedFontSize: 11,

          onTap: (selectedPage) {

            setState(() {
              _currentPage=selectedPage;
            });


          },
          selectedIconTheme: IconThemeData(color: ColorConstant.kBlueColor),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.task),
              label: "Missions",

            ),
            BottomNavigationBarItem(
              icon: Icon(
                  FontAwesomeIcons.chartBar
              ),
              label: "Domains",
            ),

            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.bitcoin),
              label: "Milestones",

            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.gamepad
              ),
              label: "Compete",
            ),
          ],
        ),
      ),
    );
  }
}