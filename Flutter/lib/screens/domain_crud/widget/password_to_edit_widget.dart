import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/authentication/views/forgot_password_email.dart';
import 'package:digi3map/screens/authentication/views/forgot_password_pin.dart';
import 'package:digi3map/screens/authentication/widgets/password_textfield.dart';
import 'package:digi3map/screens/domain_crud/provider/domain_provider.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordToEditWidget extends StatefulWidget {
  final String purpose;
  final bool forDomain;
  final String id;
  final DomainProvider provider;
  const PasswordToEditWidget({
    required this.provider,
    required this.purpose,
    this.id="",
    this.forDomain=false,
    Key? key
  }) : super(key: key);

  @override
  State<PasswordToEditWidget> createState() => _PasswordToEditWidgetState();
}

class _PasswordToEditWidgetState extends State<PasswordToEditWidget> {
  final GlobalKey<FormState> _formKey=GlobalKey();
  bool isDeleting=false;

  String _originalPassword="fasdcaewfasdfasdvcsdgawefdscvasdfwe>>23!#dsD@";
  @override
  void initState() {

    getOriginalPassword();
    super.initState();
  }
  void getOriginalPassword() async{
    isDeleting=true;
    final sharedPrefs=await SharedPreferences.getInstance();
    _originalPassword=sharedPrefs.getString(Service.passwordPrefKey)??"fasdcaewfasdfasdvcsdgawefdscvasdfwe>>23!#dsD@";
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {
        isDeleting=false;

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height*0.6,
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        insetPadding:const EdgeInsets.all(5),
        content: Card(
          elevation: 10,
          color: ColorConstant.kGreyCardColor,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Enter Password",
                    style: Styles.bigHeading,
                  ),
                  Constants.kVerySmallBox,
                  Text(
                    widget.purpose,
                    style: Styles.smallHeading,
                  ),
                  Constants.kVerySmallBox,
                  Form(
                    key: _formKey,
                    child: PasswordForm(
                      passwordChecker: passwordChecker,
                        valueProvider: ValueNotifier(null),
                        heading: "Password"
                    ),
                  ),
                  Constants.kVerySmallBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: (){

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>  ForgotPasswordEmail(

                                )));
                          },
                          child: Text(
                            'Forgot Password',
                            style: Styles.forgotPasswordStyle,
                          )
                      )
                    ],
                  ),
                  Constants.kVerySmallBox,
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                    child: isDeleting?
                    Center(child: CustomCircularIndicator(),):
                    CustomBlueButton(
                        text: "Done",
                        onPressed: () async{
                          if(_formKey.currentState!.validate()){
                            setState(() {
                              isDeleting=true;
                            });
                            await widget.provider.deleteDomain(widget.id).then((value) {
                              Navigator.pop(context);

                            }).onError((error, stackTrace){
                              setState(() {
                                isDeleting=false;
                              });
                            });

                          }
                        }
                    ),
                  ),
                  Constants.kVerySmallBox,
                  isDeleting?SizedBox():Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: Styles.blueHighlight,
                        ),
                      )
                    ],
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  bool passwordChecker(String value){
    return value==_originalPassword;
  }
}
