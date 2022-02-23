import 'dart:math';

import 'package:digi3map/common/classes/PlayAudio.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/domain_crud/widget/profile_editable_description_widget.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class VengeanceEffect extends StatefulWidget {
  final String message;
  final String sender;
  final String time;
  final bool leftAlign;

  const VengeanceEffect({
    required this.message,
    required this.sender,
    required this.time,
    this.leftAlign=true,
    Key? key
  }) : super(key: key);

  @override
  State<VengeanceEffect> createState() => _VengeanceEffectState();
}

class _VengeanceEffectState extends State<VengeanceEffect> with TickerProviderStateMixin {
  final Random random=Random();
  final normalRadius=const Radius.circular(10);

  final spikeRadius=const Radius.circular(2);

  final imageSize=50.0;
  late final AnimationController controller;
  late final Animation colorAnimation;
  late final Animation sizeAnimation;
  @override
  void initState() {
    super.initState();
    controller=AnimationController(
        vsync: this,
        duration: const Duration(seconds: 120)
    );
    colorAnimation=Tween(
      begin: 0.0,
      end: 360.0,
    ).animate(controller);
    controller.repeat();

    sizeAnimation=Tween(
      begin: 0.7,
      end: 1.3,
    ).animate(AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true));
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
        child:AnimatedBuilder(
            animation: sizeAnimation,
            builder: (context,child) {
              return Opacity(
                opacity: 0.3,
                child: Transform.scale(

                  scale: sizeAnimation.value,
                  child: Image.asset(
                      AssetsLocation.vengeanceImageLocation
                  ),
                ),
              );
            }
        ),
      animation: colorAnimation,
      builder: (context,child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 0),
          child: Column(
            children: [
              Padding(
                padding: widget.leftAlign?EdgeInsets.only(left: imageSize*0.8):EdgeInsets.only(right: imageSize*0.8),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: SweepGradient(
                      transform: GradientRotation(colorAnimation.value),
                        colors: ColorConstant.kVengeanceColors

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
                          child:child??SizedBox()
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
                                            PlayAudio.playAudio(AssetsLocation.vengeanceAudioLocation);
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
