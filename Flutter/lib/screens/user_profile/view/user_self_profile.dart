import 'package:digi3map/common/classes/PlayAudio.dart';
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/data/models/SocialModel.dart';
import 'package:digi3map/data/models/effects_model.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/domain_crud/widget/image_picker.dart';
import 'package:digi3map/screens/domain_crud/widget/profile_editable_description_widget.dart';
import 'package:digi3map/screens/domain_crud/widget/profile_heading_editable_widget.dart';
import 'package:digi3map/screens/domain_list_graph/widget/time_filter_widget.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserSelfProfile extends StatelessWidget {
  const UserSelfProfile({Key? key}) : super(key: key);

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Your Complete Profile',
                style: Styles.bigHeading,
              ),
              Constants.kSmallBox,
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Constants.kSmallBox,
                      CustomImagePicker(imageLocation: ValueNotifier(AssetsLocation.userDummyProfileLocation)),
                      ProfileHeadingEditableWidget(),
                      ScoreWidget(),
                      FollowerWidget(),
                      Constants.kVerySmallBox,
                      AnonymousWidget(),
                      ProfileEditableDescriptionWidget(),
                      Text(
                          "Email",
                        style: Styles.opacityHeadingStyle,
                      ),
                      Constants.kVerySmallBox,
                      SelectableText("aradhya.1221@gmail.com"),
                      Constants.kSmallBox,
                      SocialsWidget(),
                      Constants.kSmallBox,
                      Text(
                          "Current Effect",
                        style: Styles.mediumHeading,
                      ),
                      ActivatedEffect(
                        effectModel: EffectData.effectData[0],
                      ),
                      Constants.kSmallBox,
                      InventoryWidget(),
                      Constants.kVerySmallBox
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class InventoryWidget extends StatelessWidget {
  final List<int> effectCount=[5,3,4,0,1];
  InventoryWidget({
    Key? key,
  }) : super(key: key);

  bool isAllEmpty(){
    for(int i in effectCount){
      if(i>0) return false;
    }
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return isAllEmpty()?SizedBox():Column(
      children: [
        Row(
          children: [
            Text(
                "Inventory",
              style: Styles.mediumHeading,
            ),
            SizedBox(width: 10,),
            Text(
                "*Private Details",
              style: Styles.opacityHeadingStyle,
            )
          ],
        ),
        for(int i=0;i<effectCount.length;i++)
          InventoryEffectIndividual(
            count: effectCount[i],
            effectModel: EffectData.effectData[i],
          )
      ],
    );
  }
}


class InventoryEffectIndividual extends StatelessWidget {
  final int count;
  final EffectModel effectModel;
  const InventoryEffectIndividual({
    required this.count,
    required this.effectModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return count==0?SizedBox():Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
        color: ColorConstant.kGreyCardColor,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: double.infinity,
                        child: Card(
                          margin: const EdgeInsets.all(0),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                                effectModel.imageLocation
                            ),
                          ),
                        ),
                      ),
                      Constants.kVerySmallBox,

                      Text(
                        effectModel.name,
                        textAlign: TextAlign.center,
                        style:Styles.smallHeading ,
                      )
                    ],
                  )
              ),
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(left:10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                            alignment:Alignment.centerRight,
                            child: IconButton(
                              onPressed: (){
                                PlayAudio.playAudio(effectModel.soundLocation);
                              },
                              icon: Icon(
                                  Icons.volume_up_outlined
                              ),
                            )
                        ),
                        Constants.kVerySmallBox,
                        Text(
                          "Symbol of ${effectModel.symbolicName}",
                          style: Styles.mediumHeading,
                        ),
                        Constants.kVerySmallBox,
                        Text(
                          effectModel.description,
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Constants.kSmallBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "x$count",
                              style: Styles.bigHeading,
                            ),
                            ElevatedButton(
                                onPressed: (){},
                                child: Text(
                                    "Use",
                                  style: Styles.mediumHeading,
                                )
                            )
                          ],
                        )
                      ],
                    ),
                  )
              ),
            ],
          ),
        )
    );
  }
}

class ActivatedEffect extends StatelessWidget {
  final EffectModel effectModel;
  const ActivatedEffect({
    required this.effectModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
        color: ColorConstant.kGreyCardColor,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: double.infinity,
                        child: Card(
                          margin: const EdgeInsets.all(0),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                                effectModel.imageLocation
                            ),
                          ),
                        ),
                      ),
                      Constants.kVerySmallBox,

                      Text(
                        effectModel.name,
                        textAlign: TextAlign.center,
                        style:Styles.smallHeading ,
                      )
                    ],
                  )
              ),
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(left:10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                            alignment:Alignment.centerRight,
                            child: IconButton(
                              onPressed: (){
                                PlayAudio.playAudio(effectModel.soundLocation);
                              },
                              icon: Icon(
                                  Icons.volume_up_outlined
                              ),
                            )
                        ),
                        Constants.kVerySmallBox,
                        Text(
                          "Symbol of ${effectModel.symbolicName}",
                          style: Styles.mediumHeading,
                        ),
                        Constants.kVerySmallBox,
                        Text(
                          effectModel.description,
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Constants.kSmallBox,
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                            onPressed: (){},
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                "Activated Till \n31/12/31",
                                textAlign: TextAlign.center,
                                style: Styles.smallHeading,
                              ),
                            )
                        )
                      ],
                    ),
                  )
              ),
            ],
          ),
        )
    );
  }
}


class SocialsWidget extends StatefulWidget {
  const SocialsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SocialsWidget> createState() => _SocialsWidgetState();
}

class _SocialsWidgetState extends State<SocialsWidget> {
  final List<SocialModel> socialsWidgetList=[];
  final TextEditingController platformController=TextEditingController();
  final TextEditingController usernameController=TextEditingController();
  @override
  void initState() {
    super.initState();
    socialsWidgetList.add(
      SocialModel(
          platform: "Instagram",
          username: "anonymoussssssoul"
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            "Other Socials (Max 5)",
          style: Styles.opacityHeadingStyle,
        ),
        Constants.kVerySmallBox,
        for(int i=0;i<socialsWidgetList.length;i++)
          Row(
            children: [
              Expanded(
                  child: SelectableText(
                      socialsWidgetList[i].platform,
                    style: Styles.mediumHeading,
                  )
              ),
              SizedBox(width: 5,),
              Expanded(
                  child: SelectableText(
                    socialsWidgetList[i].username
                  )
              ),

              SizedBox(width: 5,),
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    setState(() {
                      socialsWidgetList.removeAt(i);
                    });
                  },
                  child: Text("Remove"),
                ),
              )
            ],
          ),
        Constants.kVerySmallBox,

        socialsWidgetList.length>=5?SizedBox():Row(
          children: [
            Expanded(
                child: TextField(
                  controller: platformController,
                  decoration: InputDecoration(
                    hintText: "Platform"
                  ),
                )
            ),
            SizedBox(width: 5,),
            Expanded(
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      hintText: "Username"
                  ),
                )
            ),

            SizedBox(width: 5,),
            Expanded(
              child: ElevatedButton(
                onPressed: (){
                  if(!platformController.text.isEmpty && !usernameController.text.isEmpty){
                    socialsWidgetList.add(
                        SocialModel(
                            platform: platformController.text,
                            username: usernameController.text
                        )
                    );
                    platformController.clear();
                    usernameController.clear();
                    setState(() {

                    });
                  }


                },
                child: Text("Add"),
              ),
            )
          ],
        )
      ],
    );
  }
}

class FollowerWidget extends StatelessWidget {
  const FollowerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              "Followers: 10",
            style: Styles.mediumHeading,
          ),


          Text(
            "*Only Number",
            style: Styles.opacityHeadingStyle,

          ),
        ],
      ),
    );
  }
}

class AnonymousWidget extends StatefulWidget {

  const AnonymousWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AnonymousWidget> createState() => _AnonymousWidgetState();
}

class _AnonymousWidgetState extends State<AnonymousWidget> {
  bool enabled=false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [

            Text(
              "Anonymous Mode",
              style: Styles.blueHighlight,
            ),
            Constants.kVerySmallBox,
            Text(
              "Enabled"
            )
          ],
        ),
        Switch(
            value: enabled,
            onChanged: (value){
              setState(() {
                enabled=value;
              });
            }
        )
      ],
    );
  }
}

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            "Monthly Score:",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(width: 5,),
        Text(
          "500",
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(width: 5,),
        SvgPicture.asset(
            AssetsLocation.coinIconLocation,
          height: 20,
          width: 20,
        ),
        TextButton(
            onPressed: (){
              showModalBottomSheet(
                  context: context,
                  builder: (context){
                    return TimeFilterWidget();
                  }
              );
            },
            child: Text(
              'Filter',
              style: Styles.blueHighlight,
            )
        )

      ],
    );
  }
}
