import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';

class PasswordToEditWidget extends StatefulWidget {
  const PasswordToEditWidget({Key? key}) : super(key: key);

  @override
  State<PasswordToEditWidget> createState() => _PasswordToEditWidgetState();
}

class _PasswordToEditWidgetState extends State<PasswordToEditWidget> {
  String? _password;
  bool _showPassword=false;
  final GlobalKey<FormState> _formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height*0.6,
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        insetPadding:EdgeInsets.all(5),
        content: Card(
          elevation: 10,
          color: ColorConstant.kGreyCardColor,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Enter Password",
                    style: Styles.bigHeading,
                  ),
                  Constants.kVerySmallBox,
                  Text(
                    "Domain is Sensitive Data to change.",
                    style: Styles.smallHeading,
                  ),
                  Constants.kVerySmallBox,
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Icon(Icons.lock_outline_rounded,color: ColorConstant.kIconColor,)
                          ),
                          Constants.kSmallBox,
                          Expanded(
                            flex: 8,
                            child: Form(
                              key: _formKey,
                              child: TextFormField(

                                  textInputAction: TextInputAction.next,
                                  onSaved: (value)=>_password=value,
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Please Enter Password";
                                    }
                                    return null;
                                  },
                                  obscureText:! _showPassword,
                                  decoration: Styles.getSimpleInputDecoration("Password")
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                onPressed: (){
                                  setState(() {
                                    _showPassword=!_showPassword;
                                  });
                                },
                                icon: Icon(
                                  _showPassword?Icons.visibility_off_outlined:Icons.visibility_outlined,
                                  color: ColorConstant.kIconColor,
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                  Constants.kVerySmallBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: (){

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
                    child: CustomBlueButton(
                        text: "Done",
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            Navigator.pop(context);

                          }
                        }
                    ),
                  ),
                  Constants.kVerySmallBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancle",
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
}
