import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/selection_collection.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/domain_crud/provider/domain_provider.dart';
import 'package:digi3map/screens/domain_crud/view/add_domain.dart';
import 'package:digi3map/screens/domain_crud/widget/image_picker.dart';
import 'package:digi3map/screens/domain_crud/widget/password_to_edit_widget.dart';
import 'package:digi3map/screens/domain_crud/widget/profile_editable_description_widget.dart';
import 'package:digi3map/screens/domain_crud/widget/profile_heading_editable_widget.dart';
import 'package:digi3map/screens/habit_milestone_graph_chain/view/habits_graph.dart';
import 'package:digi3map/screens/habits/widgets/open_chain_navigation_widget.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class HabitsReadDeleteUpdate extends StatelessWidget {
  HabitsReadDeleteUpdate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child:Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          padding: Constants.kPagePaddingNoDown,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Habits Details",
                style: Styles.bigHeading,
              ),
              Constants.kSmallBox,
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomImagePicker(
                          imageLocation: ValueNotifier(
                              AssetsLocation.workoutImageLocation
                          )
                      ),
                      Constants.kVerySmallBox,
                      ProfileHeadingEditableWidget(value:ValueNotifier(""),bigHighlight: true,),
                      ProfileEditableDescriptionWidget(description: ValueNotifier("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ut pulvinar lacus, a sodales purus. Donec sed dui ut libero vulputate porttitor. Donec eleifend feugiat volutpat. Nunc felis dui, convallis ut aliquam non"),),
                      Constants.kVerySmallBox,
                      Text(
                        "Domain",
                        style: Styles.opacityHeadingStyle,
                      ),
                      Constants.kVerySmallBox,
                      Wrap(
                        children: [
                          SelectionCollection(

                              value: ValueNotifier(""),
                              valuesList: [
                                "Fitness","Commander"
                              ]
                          ),
                          ElevatedButton(
                              onPressed: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => AddDomain(provider: DomainProvider(),)));
                              },
                              child: Text(
                                "Add",
                                style: Styles.mediumHeading,
                              )
                          )
                        ],
                      ),
                      Constants.kVerySmallBox,
                      Text(
                        "Widget",
                        style: Styles.opacityHeadingStyle,
                      ),
                      Constants.kVerySmallBox,
                      SelectionCollection(

                          value: ValueNotifier(""),
                          valuesList: [
                            "Sets and Reps",
                            "Time",
                            "Todo"
                          ]
                      ),
                      Constants.kVerySmallBox,
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: ColorConstant.kBlueColor),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: const Text('Save')
                      ),
                      Constants.kVerySmallBox,
                      Text(
                        "Chain",
                        style: Styles.opacityHeadingStyle,
                      ),
                      Constants.kVerySmallBox,
                      OpenChainNavigationWidget(),
                      Constants.kVerySmallBox,
                      HabitsGraph(),
                      Constants.kVerySmallBox,
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: (){
                            showPasswordModal(context);
                          },
                          child: const Text('Delete')
                      ),
                      Constants.kVerySmallBox,

                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
  void showPasswordModal(BuildContext context){
    showDialog(
        context: context,
        builder: (context){
          return PasswordToEditWidget(purpose: "Habit is Sensitive Data to change.",provider: DomainProvider(),);
        }
    );
  }
}
