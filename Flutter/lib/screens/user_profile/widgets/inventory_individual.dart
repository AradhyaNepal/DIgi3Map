
import 'package:digi3map/common/classes/PlayAudio.dart';
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/data/models/effects_model.dart';
import 'package:digi3map/screens/group_portle/view/effects_testing_page.dart';
import 'package:digi3map/screens/user_profile/provider/user_profile_provider.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventoryEffectIndividual extends StatefulWidget {
  final int count;
  final EffectModel effectModel;
  const InventoryEffectIndividual({
    required this.count,
    required this.effectModel,
    Key? key,
  }) : super(key: key);

  @override
  State<InventoryEffectIndividual> createState() => _InventoryEffectIndividualState();
}

class _InventoryEffectIndividualState extends State<InventoryEffectIndividual> {
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return widget.count==0?SizedBox():
    GestureDetector(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EffectTestingPage(effectType: widget.effectModel.effectType)));
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
                                  widget.effectModel.imageLocation
                              ),
                            ),
                          ),
                        ),
                        Constants.kVerySmallBox,

                        Text(
                          widget.effectModel.name,
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
                                  "Symbol of ${widget.effectModel.symbolicName}",
                                  style: Styles.mediumHeading,
                                ),
                              ),
                              IconButton(
                                onPressed: (){
                                  PlayAudio.playAudio(widget.effectModel.soundLocation);
                                },
                                icon: Icon(
                                    Icons.volume_up_outlined
                                ),
                              )
                            ],
                          ),
                          Constants.kVerySmallBox,
                          Text(
                            widget.effectModel.description,
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Constants.kSmallBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "x${widget.count}",
                                style: Styles.bigHeading,
                              ),
                              isLoading?CustomCircularIndicator():ElevatedButton(
                                  onPressed: (){
                                    setState(() {
                                      isLoading=true;
                                    });
                                    Provider.of<UserProfileProvider>(context,listen: false).activateEffect(widget.effectModel.id).then((value) {
                                      setState(() {
                                        isLoading=false;
                                      });

                                      CustomSnackBar.showSnackBar(context, "Successfully Activated The Effect");
                                    }).onError((error, stackTrace){
                                      setState(() {
                                        isLoading=false;
                                      });
                                      CustomSnackBar.showSnackBar(context, error.toString());
                                    });

                                  },
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
      ),
    );
  }
}
