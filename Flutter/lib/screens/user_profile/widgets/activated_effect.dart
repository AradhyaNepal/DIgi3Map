
import 'package:digi3map/common/classes/PlayAudio.dart';
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/data/models/effects_model.dart';
import 'package:digi3map/screens/group_portle/view/effects_testing_page.dart';
import 'package:digi3map/screens/user_profile/provider/user_profile_provider.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class ActivatedEffect extends StatefulWidget {
  final ActivatedEffectModel effectModel;
  const ActivatedEffect({
    required this.effectModel,
    Key? key,
  }) : super(key: key);

  @override
  State<ActivatedEffect> createState() => _ActivatedEffectState();
}

class _ActivatedEffectState extends State<ActivatedEffect> {
  EffectModel? effectModel;
  @override
  void initState() {
    super.initState();
    try{
      effectModel=EffectData.effectData.firstWhere((element) => element.id==widget.effectModel.effectId);

    // ignore: empty_catches
    }catch(e){

    }
  }
  @override
  Widget build(BuildContext context) {
    return effectModel==null?
    SizedBox():
    InkWell(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EffectTestingPage(effectType: effectModel!.effectType)));
      },
      child: Card(
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
                                  effectModel!.imageLocation
                              ),
                            ),
                          ),
                        ),
                        Constants.kVerySmallBox,

                        Text(
                          effectModel!.name,
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

                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  "Symbol of ${effectModel!.symbolicName}",
                                  style: Styles.mediumHeading,
                                ),
                              ),
                              IconButton(
                                onPressed: (){
                                  PlayAudio.playAudio(effectModel!.soundLocation);
                                },
                                icon: Icon(
                                    Icons.volume_up_outlined
                                ),
                              )
                            ],
                          ),
                          Constants.kVerySmallBox,
                          Text(
                            effectModel!.description,
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
      ),
    );
  }
}
