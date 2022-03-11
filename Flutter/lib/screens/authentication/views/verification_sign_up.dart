import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/screens/authentication/provides/pin_value_provider.dart';
import 'package:digi3map/screens/authentication/widgets/pin_widget.dart';
import 'package:digi3map/screens/homepage/views/home_page.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VerificationSignUp extends StatelessWidget {
  final ValueNotifier<List<String>> _pinValue=ValueNotifier([]);
  final GlobalKey<FormState> formKey=GlobalKey();

  VerificationSignUp({Key? key}) : super(key: key);
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
                              "Verification(123456)",
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
                                    child??SizedBox(),
                                    Constants.kSmallBox,
                                    IgnorePointer(
                                      ignoring: !pinValueProvider.isCorrectValueToContinue,
                                      child: CustomBlueButton(
                                          text: pinValueProvider.buttonValue,//"Done",
                                          onPressed: (){
                                            CustomSnackBar.showSnackBar(context, "Successfully Created New Account");
                                            //IsLoggedValue.loggedIn();
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context) =>  HomePage()));
                                          }
                                      ),
                                    ),
                                  ],
                                );
                              },
                              child: PinWidget(
                                pinValue: _pinValue,
                              ),
                            ),
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
