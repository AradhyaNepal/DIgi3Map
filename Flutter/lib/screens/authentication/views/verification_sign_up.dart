import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/authentication/provides/PinValueProvider.dart';
import 'package:digi3map/screens/authentication/widgets/PinWidget.dart';
import 'package:digi3map/testing_all_navigation.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VerificationSignUp extends StatelessWidget {
  final ValueNotifier<List<String>> _pinValue=ValueNotifier([]);
  final GlobalKey<FormState> formKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context)=>PinValueProvider(correctValue: "123456"),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Spacer(),
                  Padding(
                    padding: Constants.kPagePadding,
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: Constants.kPagePadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Verification",
                              style: Styles.bigHeading
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
                                    PinWidget(
                                      pinValue: _pinValue,
                                      pinValueProvider: pinValueProvider,

                                    ),
                                    Constants.kSmallBox,
                                    IgnorePointer(
                                      ignoring: !pinValueProvider.isCorrectValueToContinue,
                                      child: CustomBlueButton(
                                          text: pinValueProvider.buttonValue,//"Done",
                                          onPressed: (){
                                            TestingAllNavigation.goToTestingPage(context);
                                          }
                                      ),
                                    ),
                                  ],
                                );
                              }
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Spacer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
