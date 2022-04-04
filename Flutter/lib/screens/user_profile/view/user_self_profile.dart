import 'package:digi3map/common/classes/PlayAudio.dart';
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/data/models/SocialModel.dart';
import 'package:digi3map/data/models/effects_model.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/domain_crud/widget/image_picker.dart';
import 'package:digi3map/screens/domain_crud/widget/profile_editable_description_widget.dart';
import 'package:digi3map/screens/domain_crud/widget/profile_heading_editable_widget.dart';
import 'package:digi3map/screens/user_profile/provider/user_profile_provider.dart';
import 'package:digi3map/screens/user_profile/widgets/activated_effect.dart';
import 'package:digi3map/screens/user_profile/widgets/anonymous_widget.dart';
import 'package:digi3map/screens/user_profile/widgets/editable_social_widget.dart';
import 'package:digi3map/screens/user_profile/widgets/inventory_widget.dart';
import 'package:digi3map/screens/user_profile/widgets/score_widget.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserSelfProfile extends StatelessWidget {
  const UserSelfProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context)=>UserProfileProvider(),
      child: SafeArea(
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
                    child: Consumer<UserProfileProvider>(
                      builder: (context,provider,child) {
                        if(provider.details==null){
                          return SizedBox(
                            height: size.height*0.8,
                            child: Center(
                                child: CustomCircularIndicator()
                            ),
                          );
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Constants.kSmallBox,
                            UserImageWidget(userImage: provider.details?.imageUrl,),

                            Constants.kVerySmallBox,
                            ProfileHeadingEditableWidget(value:ValueNotifier(provider.details?.username??""),bigHighlight: true,),
                            Constants.kVerySmallBox,
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Followers Count: 10",
                                style: Styles.mediumHeading,
                              ),
                            ),
                            ScoreWidget(),
                            AnonymousWidget(),

                            ProfileEditableDescriptionWidget(description: ValueNotifier("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ut pulvinar lacus, a sodales purus. Donec sed dui ut libero vulputate porttitor. Donec eleifend feugiat volutpat. Nunc felis dui, convallis ut aliquam non"),),

                            Constants.kVerySmallBox,
                            Text(
                                "Email",
                              style: Styles.opacityHeadingStyle,
                            ),
                            Constants.kVerySmallBox,
                            SelectableText(provider.details?.email??""),
                            Constants.kSmallBox,
                            EditableSocialWidget(),
                            Constants.kSmallBox,
                            Text(
                                "Current Effect",
                              style: Styles.mediumHeading,
                            ),
                            Consumer<UserProfileProvider>(
                              builder: (context,provider,child) {
                                return provider.activatedEffect==null?
                                SizedBox():ActivatedEffect(
                                  activatedEffect: provider.activatedEffect!,
                                );
                              }
                            ),
                            Constants.kSmallBox,
                            InventoryWidget(),
                            Constants.kVerySmallBox
                          ],
                        );
                      }
                    ),
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

class UserImageWidget extends StatefulWidget {
  final String? userImage;

  const UserImageWidget({
    required this.userImage,
    Key? key,
  }) : super(key: key);

  @override
  State<UserImageWidget> createState() => _UserImageWidgetState();
}

class _UserImageWidgetState extends State<UserImageWidget> {
  late final ValueNotifier<String?> userValue;
  final ValueNotifier<bool> imageSelected=ValueNotifier(false);
  bool isLoading=false;
  bool fromServer=false;
  @override
  void initState() {
    super.initState();
    userValue=ValueNotifier(widget.userImage);
    fromServer=userValue.value!=null;
    userValue.value ??= AssetsLocation.userDummyProfileLocation;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomImagePicker(
          imageSelected: imageSelected,
          imageLocation: userValue,
          fromServer: fromServer,

        ),
        Center(
          child: isLoading?CustomCircularIndicator():IconButton(
            onPressed: () async{
              if(imageSelected.value){
                setState(() {
                  isLoading=true;
                });
                await Provider.of<UserProfileProvider>(context,listen: false)
                    .updateProfilePicture(imagePath: userValue.value??"").then((value) {
                      CustomSnackBar.showSnackBar(context, "Successfully Updated");
                }).onError((error, stackTrace){
                      CustomSnackBar.showSnackBar(context, error.toString());

                });
                setState(() {
                  isLoading=false;
                });
              }
            },
            icon: Icon(
                Icons.save_alt_outlined
            ),
          ),
        ),
      ],
    );
  }
}




