import 'package:digi3map/common/constants.dart';
import 'package:digi3map/data/models/effects_model.dart';
import 'package:digi3map/screens/effect_shop/provider/shop_provider.dart';
import 'package:digi3map/screens/effect_shop/widgets/shop_effects_item_widget.dart';
import 'package:digi3map/screens/effect_shop/widgets/trophy_count_widget.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context)=>ShopProvider(),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            padding: Constants.kPagePaddingNoDown,
            height: size.height,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Special Effect Shop",
                  style: Styles.bigHeading,
                ),
                Consumer<ShopProvider>(
                  builder: (context,provider,child) {
                    return TrophyCountWidget(
                      count: provider.totalTrophy,
                    );
                  }
                ),
                Text(
                    "Buy",
                  style: Styles.mediumHeading,
                ),
                Constants.kVerySmallBox,
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      for(int i=0;i<EffectData.effectData.length;i++)
                        ShopEffectsItemWidget(
                          index: i,
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
