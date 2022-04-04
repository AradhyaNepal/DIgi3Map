import 'dart:math';

import 'package:digi3map/common/classes/PlayAudio.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/domain_crud/widget/profile_editable_description_widget.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class PassionEffect extends StatefulWidget {
  final String message;
  final String sender;
  final String time;
  final bool leftAlign;
  final String? userImage;
  const PassionEffect({
    this.userImage,
    required this.message,
    required this.sender,
    required this.time,
    this.leftAlign=true,
    Key? key
  }) : super(key: key);

  @override
  State<PassionEffect> createState() => _PassionEffectState();
}

class _PassionEffectState extends State<PassionEffect> with TickerProviderStateMixin {
  final normalRadius=const Radius.circular(10);
  final Random random=Random();

  final spikeRadius=const Radius.circular(2);

  final imageSize=50.0;
  late final Animation colorAnimation;
  late final AnimationController colorController;
  late final Animation sizeAnimation;
  late final AnimationController sizeController;
  @override
  void initState() {
    super.initState();
    colorController=AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    colorAnimation=Tween(
      begin: 0.0,
      end: 100.0,
    ).animate(colorController);
    sizeController=AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    sizeAnimation=Tween(
      begin: 0.6,
      end: 1,
    ).animate(sizeController);
  }

  @override
  void dispose() {
    sizeController.dispose();
    colorController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
      child: AnimatedBuilder(
        animation: sizeAnimation,
        builder: (context,child) {
          return Opacity(
            opacity: 0.4,
            child: Transform.scale(

              scale: sizeAnimation.value,
              child: Image.asset(
                  AssetsLocation.passionImageLocation
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
                      gradient: LinearGradient(
                          transform: GradientRotation((colorAnimation.value+colorAnimation.value/2)/2),
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
                            child: child??SizedBox()
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

                                        key:ValueKey(widget.sender),
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

                                  key:ValueKey(widget.message),
                                  editable: false,
                                  isMessage: true,
                                  description: ValueNotifier(widget.message),
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                                Text(
                                  widget.time,

                                  key:ValueKey(widget.time),
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
                    child:  widget.userImage!=null?
                    Image.network(
                      Service.baseApiNoDash+widget.userImage!,
                      height: imageSize,
                      width: imageSize,

                      fit: BoxFit.cover,
                    ):Image.asset(
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
