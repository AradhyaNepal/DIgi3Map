import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/group_portle/provider/leaderboard_provider.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CongratulationPage extends StatefulWidget {
  final List<int> winnerLeaderBoardIds;
  const CongratulationPage({
    required this.winnerLeaderBoardIds,
    Key? key
  }) : super(key: key);

  @override
  State<CongratulationPage> createState() => _CongratulationPageState();
}

class _CongratulationPageState extends State<CongratulationPage> {
  bool isLoading=false;
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
                        "You Are The Winner in ${widget.winnerLeaderBoardIds.length} Monthly LeaderBoard",
                      textAlign: TextAlign.center,
                      style: Styles.smallHeading,
                    ),
                    Constants.kMediumBox,
                    const TrophyAnimationWidget(),
                    Constants.kMediumBox,


                  ],
                ),
                isLoading?CustomCircularIndicator():
                CustomBlueButton(
                    text: "Collect",
                    onPressed: (){
                      print("hello");
                      setState(() {
                        isLoading=true;
                      });
                      print("hello");
                      LeaderboardProvider.collectTrophy(widget.winnerLeaderBoardIds).then((value){
                        CustomSnackBar.showSnackBar(context, "Successfully Collected");
                        Navigator.pop(context);

                      }).onError((error, stackTrace){
                        CustomSnackBar.showSnackBar(
                            context, error.toString()
                        );
                        setState(() {
                          isLoading=false;
                        });

                      });
                    }
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
  late final AnimationController controller;
  late final Tween tween;
  @override
  void initState() {
    super.initState();
    controller=AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    tween=Tween(
      begin: 0.7,
      end: 1,
    );
    sizeAnimation=tween.animate(controller);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    controller.stop();
    controller.dispose();
    super.dispose();
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
