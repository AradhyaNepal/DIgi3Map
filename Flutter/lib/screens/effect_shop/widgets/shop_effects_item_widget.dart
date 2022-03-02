
import 'package:digi3map/common/classes/PlayAudio.dart';
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/data/models/effects_model.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/group_portle/view/effects_testing_page.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShopEffectsItemWidget extends StatelessWidget {
  final int index;
  const ShopEffectsItemWidget({
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EffectModel effectModel=EffectData.effectData[index];
    int recommendedEffectId=EffectData.recommendedEffectId;
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context)=>EffectTestingPage(effectType: effectModel.effectType)
            )
        );
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  "Symbol of ${effectModel.symbolicName}",
                                  style: Styles.mediumHeading,
                                ),
                              ),
                              IconButton(
                                onPressed: (){
                                  PlayAudio.playAudio(effectModel.soundLocation);
                                },
                                icon: Icon(
                                    Icons.volume_up_outlined
                                ),
                              )
                            ],
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Wrap(
                                  alignment: WrapAlignment.end,
                                  children: [
                                    for(int i=0;i<effectModel.trophy;i++)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                        child: SvgPicture.asset(
                                          AssetsLocation.trophyIconLocation,
                                          height: 25,
                                          width: 25,
                                        ),
                                      ),
                                  ],
                                ),
                              ),

                              Constants.kSmallBox,
                              Expanded(
                                flex: 5,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(primary: ColorConstant.kBlueColor),
                                    onPressed: (){

                                    },
                                    child: Text(
                                      'Buy',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white
                                      ),
                                    )
                                ),
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
      ),
    );
  }
}
