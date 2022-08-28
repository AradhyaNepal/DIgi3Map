
import 'package:digi3map/data/services/assets_location.dart';
import 'package:flutter/material.dart';

class PlayersCallListWidget extends StatelessWidget {
  const PlayersCallListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height*0.25,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for(int i=0;i<5;i++)
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: Image.asset(
                    AssetsLocation.userDummyProfileLocation
                ),
              )
          ],
        ),
      ),
    );
  }
}
