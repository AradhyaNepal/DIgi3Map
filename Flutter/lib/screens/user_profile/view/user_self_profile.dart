import 'package:digi3map/common/classes/PlayAudio.dart';
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/data/models/SocialModel.dart';
import 'package:digi3map/data/models/effects_model.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/domain_crud/widget/image_picker.dart';
import 'package:digi3map/screens/domain_crud/widget/profile_editable_description_widget.dart';
import 'package:digi3map/screens/domain_crud/widget/profile_heading_editable_widget.dart';
import 'package:digi3map/screens/user_profile/widgets/activated_effect.dart';
import 'package:digi3map/screens/user_profile/widgets/anonymous_widget.dart';
import 'package:digi3map/screens/user_profile/widgets/editable_social_widget.dart';
import 'package:digi3map/screens/user_profile/widgets/inventory_widget.dart';
import 'package:digi3map/screens/user_profile/widgets/score_widget.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class UserSelfProfile extends StatelessWidget {
  const UserSelfProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          padding: Constants.kPagePaddingNoDown,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Your Complete Profile',
                style: Styles.bigHeading,
              ),
              Constants.kSmallBox,
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Constants.kSmallBox,
                      CustomImagePicker(imageLocation: ValueNotifier(AssetsLocation.userDummyProfileLocation)),
                      ProfileHeadingEditableWidget(bigHighlight: true,),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Followers Count: 10",
                          style: Styles.mediumHeading,
                        ),
                      ),
                      ScoreWidget(),
                      AnonymousWidget(),
                      ProfileEditableDescriptionWidget(),
                      Text(
                          "Email",
                        style: Styles.opacityHeadingStyle,
                      ),
                      Constants.kVerySmallBox,
                      SelectableText("aradhya.1221@gmail.com"),
                      Constants.kSmallBox,
                      EditableSocialWidget(),
                      Constants.kSmallBox,
                      Text(
                          "Current Effect",
                        style: Styles.mediumHeading,
                      ),
                      ActivatedEffect(
                        effectModel: EffectData.effectData[0],
                      ),
                      Constants.kSmallBox,
                      InventoryWidget(),
                      Constants.kVerySmallBox
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}




