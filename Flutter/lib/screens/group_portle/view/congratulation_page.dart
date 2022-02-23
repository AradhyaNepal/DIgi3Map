import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CongratulationPage extends StatelessWidget {
  const CongratulationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          padding: Constants.kPagePaddingNoDown,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Leaderboard Winner",
                  style: Styles.bigHeading,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Constants.kSmallBox,
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: ClipOval(
                        child: Image.asset(
                            AssetsLocation.userDummyProfileLocation
                        ),
                      ),
                    ),
                    Constants.kSmallBox,
                    Text(
                        "Congratulation!!",
                      style: Styles.bigHeading,
                    ),
                    Constants.kSmallBox,
                    Text(
                        "You Are The Winner In This Month's LeaderBoard",
                      textAlign: TextAlign.center,
                      style: Styles.smallHeading,
                    ),
                    Constants.kMediumBox,
                    TrophyAnimationWidget(),
                    Constants.kMediumBox,


                  ],
                ),
                CustomBlueButton(
                    text: "Collect",
                    onPressed: (){}
                ),
                Constants.kSmallBox,

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TrophyAnimationWidget extends StatefulWidget {
  const TrophyAnimationWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TrophyAnimationWidget> createState() => _TrophyAnimationWidgetState();
}

class _TrophyAnimationWidgetState extends State<TrophyAnimationWidget>  with SingleTickerProviderStateMixin{

  late final Animation sizeAnimation;
  @override
  void initState() {
    super.initState();
    sizeAnimation=Tween(
      begin: 0.7,
      end: 1,
    ).animate(AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true));
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: sizeAnimation,
      builder: (context,child){
        return  Transform.scale(
          scale: sizeAnimation.value,
          child: SvgPicture.asset(
            AssetsLocation.trophyIconLocation,
            height: 200,
            width: 200,
          ),
        );
      },
    );
  }
}
