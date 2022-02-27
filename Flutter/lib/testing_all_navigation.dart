import 'package:digi3map/screens/authentication/views/change_password_oldpass.dart';
import 'package:digi3map/screens/authentication/views/change_password_pin.dart';
import 'package:digi3map/screens/authentication/views/forgot_password_pin.dart';
import 'package:digi3map/screens/authentication/views/login.dart';
import 'package:digi3map/screens/authentication/views/signup.dart';
import 'package:digi3map/screens/authentication/views/verification_sign_up.dart';
import 'package:digi3map/screens/diet/view/customize_body_detail.dart';
import 'package:digi3map/screens/diet/view/diet_page.dart';
import 'package:digi3map/screens/domain_list_graph/view/domain_graph.dart';
import 'package:digi3map/screens/domain_list_graph/view/domain_list.dart';
import 'package:digi3map/screens/effect_shop/view/shop_page.dart';
import 'package:digi3map/screens/fitness_page/view/fitness_edit.dart';
import 'package:digi3map/screens/fitness_page/view/fitness_page.dart';
import 'package:digi3map/screens/fitness_page/view/workout_doing.dart';
import 'package:digi3map/screens/group_portle/view/congratulation_page.dart';
import 'package:digi3map/screens/group_portle/view/effects_testing_page.dart';
import 'package:digi3map/screens/group_portle/view/friendly_competition.dart';
import 'package:digi3map/screens/group_portle/view/group_chat.dart';
import 'package:digi3map/screens/group_portle/view/leaderboard_group.dart';
import 'package:digi3map/screens/group_portle/widget/user_popup_testing.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/view/habits_chain_page.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/view/habits_graph.dart';
import 'package:digi3map/screens/habits/view/habits_create.dart';
import 'package:digi3map/screens/habits/view/habits_read_delete_update.dart';
import 'package:digi3map/screens/homepage/views/homepage.dart';
import 'package:digi3map/screens/homepage/views/random_todo_add.dart';
import 'package:digi3map/screens/homepage/views/splash_page.dart';
import 'package:digi3map/screens/homepage/widgets/energy_filter_widget.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/view/milestone_page.dart';
import 'package:digi3map/screens/on_boarding/view/on_boarding.dart';
import 'package:digi3map/screens/study_page/view/study_page.dart';
import 'package:digi3map/screens/user_profile/view/user_others_profile.dart';
import 'package:digi3map/screens/user_profile/view/user_self_profile.dart';
import 'package:flutter/material.dart';

class TestingAllNavigation extends StatelessWidget {
  const TestingAllNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; //Testing ko bela app close nai huna paudaina by clicking back button
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Testing All Navigation"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: const Text("Homepage"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SplashPage()));
              },
              child: const Text("Splash Page"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const OnBoarding()));
              },
              child: const Text("On Boarding"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const Text("Login"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()));
              },
              child: const Text("SignUp"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  VerificationSignUp()));
              },
              child: const Text("Verification Sign Up (123456)"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  ForgotPasswordPin()));
              },
              child: const Text("Forgot Password (123456)"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  const ChangePasswordWithOld()));
              },
              child: const Text("Change Password With Old"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  const ChangePasswordAfterPin()));
              },
              child: const Text("Change Password After Pin"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const DomainList()));
              },
              child: const Text("Domain"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const EnergyFilterTestingWidget()));
              },
              child: const Text("Energy Filter"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const RandomTodoAdd()));
              },
              child: const Text("Random Todo Add"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const DomainGraph()));
              },
              child: const Text("Domain Graph"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CustomBodyDetails()));
              },
              child: const Text("Custom Body Details"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MileStonePage()));
              },
              child: const Text("Milestone Page"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const StudyPage()));
              },
              child: const Text("Study Page"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ShopPage()));
              },
              child: const Text("Shop"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const UserSelfProfile()));
              },
              child: const Text("User Self Profile"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const UserOtherProfile()));
              },
              child: const Text("User Others Profile"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const EffectTestingPage(effectType: EffectType.death)));
              },
              child: const Text("Death Effect Page"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const EffectTestingPage(effectType: EffectType.sanity)));
              },
              child: const Text("Sanity Effect Page"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const EffectTestingPage(effectType: EffectType.vengeance)));
              },
              child: const Text("Vengeance Effect Page"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const EffectTestingPage(effectType: EffectType.passion)));
              },
              child: const Text("Passion Effect Page"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const EffectTestingPage(effectType: EffectType.hope)));
              },
              child: const Text("Hope Effect Page"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HabitsReadDeleteUpdate()));
              },
              child: const Text("Habits Detail"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddHabits()));
              },
              child: const Text("Habits Add"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HabitsGraph()));
              },
              child: const Text("Habits Graph"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HabitChain()));
              },
              child: const Text("Habit Chain"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const DietPage()));
              },
              child: const Text("Diet Page"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CongratulationPage()));
              },
              child: const Text("Congratulation Page"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GroupChat()));
              },
              child: const Text("Group Chat"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserProfilePopupTesting(
                    )));
              },
              child: const Text("Effect Profile Popup Page"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LeaderboardInGroup(
                    )));
              },
              child: const Text("Leaderboard Winner"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FriendlyCompetition(
                    )));
              },
              child: const Text("Friendly Winner"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FitnessPage()));
              },
              child: const Text("Fitness Page"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FitnessEditAdd()));
              },
              child: const Text("Edit Workout"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FitnessEditAdd(forAdding: true,)));
              },
              child: const Text("Add Workout"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WorkoutDoing()));
              },
              child: const Text("Workout Doing"),
            ),

          ],
        ),
      ),
    );
  }

  static void goToTestingPage(BuildContext context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const TestingAllNavigation()));
  }
}
