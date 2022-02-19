import 'dart:math';

import 'package:digi3map/common/classes/PlayAudio.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/domain_crud/widget/profile_editable_description_widget.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class PassionEffect extends StatefulWidget {
  final String message;
  final String sender;
  final String time;
  final bool leftAlign;

  const PassionEffect({
    required this.message,
    required this.sender,
    required this.time,
    this.leftAlign=true,
    Key? key
  }) : super(key: key);

  @override
  State<PassionEffect> createState() => _PassionEffectState();
}

class _PassionEffectState extends State<PassionEffect> with SingleTickerProviderStateMixin {
  final normalRadius=const Radius.circular(10);
  final Random random=Random();

  final spikeRadius=const Radius.circular(2);

  final imageSize=50.0;
  late final Animation animation;
  @override
  void initState() {
    super.initState();
    animation=Tween(
      begin: 0.0,
      end: 100.0,
    ).animate(AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat());
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
        animation: animation,
        builder: (context,child) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 0),
            child: Column(
              children: [
                Padding(
                  padding: widget.leftAlign?EdgeInsets.only(left: imageSize*0.8):EdgeInsets.only(right: imageSize*0.8),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          transform: GradientRotation((animation.value+animation.value/2)/2),
                          colors: ColorConstant.kPassionColors

                      ),
                      borderRadius: BorderRadius.only(
                        topRight: normalRadius,
                        topLeft: normalRadius,
                        bottomLeft: widget.leftAlign?spikeRadius:normalRadius,
                        bottomRight: widget.leftAlign?normalRadius:spikeRadius,
                      )
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Image.asset(
                                AssetsLocation.passionImageLocation
                            )
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        widget.sender,
                                        style: Styles.smallHeading,
                                      ),
                                    ),
                                    Expanded(
                                      child: FittedBox(
                                        child: IconButton(
                                            onPressed: (){
                                              PlayAudio.playAudio(AssetsLocation.passionAudioLocation);
                                            },
                                            icon: Icon(
                                                Icons.volume_up
                                            )
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                ProfileEditableDescriptionWidget(
                                  editable: false,
                                  isMessage: true,
                                  description: widget.message,
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                                Text(
                                  "11:00 pm",
                                  textAlign: widget.leftAlign?TextAlign.left:TextAlign.right,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            )
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: widget.leftAlign?Alignment.centerLeft:Alignment.centerRight,
                  child: ClipOval(
                    child: Image.asset(
                      AssetsLocation.userDummyProfileLocation,
                      height: imageSize,
                      width: imageSize,
                    ),
                  ),
                )
              ],
            ),
          );
        }
    );
  }
}
