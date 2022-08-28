import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialWidget extends StatefulWidget {
  const SocialWidget({Key? key}) : super(key: key);

  @override
  State<SocialWidget> createState() => _SocialWidgetState();
}

class _SocialWidgetState extends State<SocialWidget> {
  bool facebookLoading=false;
  bool googleLoading=false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Divider(
                    thickness: 1.7,
                    color: Colors.black,
                  ),
                )
            ),
            Text(
              "OR",
              style: GoogleFonts.openSans(
                  fontSize: 15
              ),
            ),
            const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Divider(

                    thickness: 1.7,
                    color: Colors.black,
                  ),
                )
            ),
          ],
        ),
        Constants.kSmallBox,
        Text(
          'Continue With Social Networks',
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w600
          ),
        ),
        Constants.kSmallBox,
        Row(
          children: [
            const Spacer(),
            googleLoading?CustomCircularIndicator():GestureDetector(
              onTap: () async{
                setState(() {
                  googleLoading=true;
                });
                 //try {
                  GoogleSignIn _googleSignIn = GoogleSignIn();
                  bool signedIn=await _googleSignIn.isSignedIn();
                  if(signedIn){
                    print("Signed Out");
                    await _googleSignIn.signOut();
                  }
                  await _googleSignIn.signIn().then((value) {
                    try{
                      value!.authentication.then((googleKey){
                        print("Google Token ${googleKey.accessToken}");
                        print("Account Name ${_googleSignIn.currentUser!.displayName}");
                      }).catchError((err){
                        print('inner error');
                      });
                    }catch(e){

                    }

                  });
                // } catch (error) {
                //
                //   print(error);
                // }
                setState(() {
                  googleLoading=false;
                });
              },
              child: SvgPicture.asset(
                AssetsLocation.googleLogo,
                height: 50,
                width: 50,
              ),
            ),
            const Spacer(),
            facebookLoading?CustomCircularIndicator():GestureDetector(
              onTap: () async{
                setState(() {
                  facebookLoading=true;
                });
                final LoginResult result = await FacebookAuth.instance.login();
                if (result.status == LoginStatus.success) {
                  final AccessToken accessToken = result.accessToken!;
                  print("Facebook Token ${accessToken.token}");
                  print("Facebook Message ${result.message}");

                } else {
                  print(result.status);
                  print(result.message);
                }
                setState(() {
                  facebookLoading=false;
                });
              },
              child: SvgPicture.asset(
                AssetsLocation.facebookLogo,
                height: 60,
                width: 60,
              ),
            ),
            const Spacer()
          ],
        )
      ],
    );
  }
}
