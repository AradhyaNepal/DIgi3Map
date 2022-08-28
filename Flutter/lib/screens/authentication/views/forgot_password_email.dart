import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/authentication/provides/auth.dart';
import 'package:digi3map/screens/authentication/views/forgot_password_pin.dart';
import 'package:digi3map/screens/authentication/widgets/custom_textfield.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordEmail extends StatefulWidget {

  ForgotPasswordEmail({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordEmail> createState() => _ForgotPasswordEmailState();
}

class _ForgotPasswordEmailState extends State<ForgotPasswordEmail> {
  bool _isLoading=false;
  final ValueNotifier<String?> _emailValue=ValueNotifier(null);

  final GlobalKey<FormState> formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child:  SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                Padding(
                  padding: Constants.kPagePadding,
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: Constants.kPagePadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Your Email",
                            style: TextStyle(
                                fontFamily: AssetsLocation.twCenName,
                                fontWeight: FontWeight.bold,
                                fontSize: 25
                            ),
                          ),
                          Constants.kSmallBox,
                          Text(
                            'Please Enter Your Gmail Address',
                            style: GoogleFonts.roboto(
                                color: ColorConstant.kGreyTextColor
                            ),
                          ),
                          Constants.kSmallBox,
                          Form(
                            key: formKey,
                            child: CustomTextfield(
                                heading: "Email",
                                valueNotifier: _emailValue,
                            ),
                          ),
                          Constants.kSmallBox,
                          _isLoading?const CustomCircularIndicator():CustomBlueButton(
                              text: "Send Code",
                              onPressed: (){
                                if(formKey.currentState!.validate()){
                                  formKey.currentState!.save();
                                  setState(() {
                                    _isLoading=true;
                                  });
                                  Auth().resetPasswordEmail(_emailValue.value??"").then((value){
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) => ForgotPasswordPin()));
                                  }).onError((error, stackTrace){
                                    print(error.toString());
                                    setState(() {
                                      _isLoading=false;
                                      CustomSnackBar.showSnackBar(context, error.toString());
                                    });
                                  });
                                }
                              }
                          )

                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
