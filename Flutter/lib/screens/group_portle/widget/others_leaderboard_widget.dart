
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/group_portle/widget/user_popup_testing.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OthersLeaderboardIndividual extends StatelessWidget {
  const OthersLeaderboardIndividual({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    showDialog(

                        context: context,
                        builder: (_){
                          return
                            NormalLeaderBoardWidget();
                        }
                    );
                  },
                  child: Image.asset(
                      AssetsLocation.userDummyProfileLocation
                  ),
                ),
              ),
              SizedBox(width: 20,),
              Expanded(
                flex: 3,
                child: FittedBox(
                  child: Text(
                    "Aaradhya Nepal",
                    style: Styles.bigHeading,
                  ),
                ),
              ),
              SizedBox(width: 20,),
              Expanded(
                child: FittedBox(
                  child: Text(
                    "100",
                    style: Styles.bigHeading,
                  ),
                ),
              ),

              SizedBox(width: 10,),
              SvgPicture.asset(
                AssetsLocation.coinIconLocation,
                height: 30,
                width: 30,
              ),


            ],
          ),
        ),
      ),
    );
  }
}
