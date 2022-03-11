import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/authentication/provides/pin_value_provider.dart';
import 'package:digi3map/screens/authentication/views/change_password_pin.dart';
import 'package:digi3map/screens/authentication/widgets/pin_widget.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPin extends StatelessWidget {
  final ValueNotifier<List<String>> _pinValue=ValueNotifier([]);
  final GlobalKey<FormState> formKey=GlobalKey();

  ForgotPasswordPin({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context)=>PinValueProvider(correctValue: "123456"),
      child: SafeArea(
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
                              "Forgot Password(123456)",
                              style: TextStyle(
                                  fontFamily: AssetsLocation.twCenName,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25
                              ),
                            ),
                            Constants.kSmallBox,
                            Text(
                              'A 6 - Digit PIN has been sent to your email address, enter it below to continue',
                              style: GoogleFonts.roboto(
                                  color: ColorConstant.kGreyTextColor
                              ),
                            ),
                            Constants.kSmallBox,

                            Consumer<PinValueProvider>(
                                builder: (context,pinValueProvider,child) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      child??SizedBox(),
                                      Constants.kSmallBox,
                                      IgnorePointer(
                                        ignoring: !pinValueProvider.isCorrectValueToContinue,
                                        child: CustomBlueButton(
                                            text: pinValueProvider.buttonValue,//"Done",
                                            onPressed: (){
                                              Navigator.pushReplacement(context,
                                                  MaterialPageRoute(builder: (context) => ChangePasswordAfterPin()));
                                            }
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              child: PinWidget(
                                pinValue: _pinValue,
                              ),
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
      ),
    );
  }
}
