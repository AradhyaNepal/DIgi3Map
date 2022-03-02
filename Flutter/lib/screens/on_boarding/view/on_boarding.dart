
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_big_blue_button.dart';
import 'package:digi3map/common/widgets/logo_widget.dart';
import 'package:digi3map/screens/authentication/views/login.dart';
import 'package:digi3map/screens/on_boarding/widgets/image_for_onboarding.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int page=0;
  late final PageController _pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController=PageController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: Constants.kPagePaddingNoDown,
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  height: 30,
                  child: const FittedBox(child: LogoWidget())
              ),
              Expanded(
                flex: 8,
                child: Center(
                  child: SingleChildScrollView(
                    physics:const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Constants.kSmallBox,
                        ImagesForOnBoarding(
                            page: page,
                            pageController:_pageController,
                            changedFunction: (currentPage){
                              setState(() {
                                page=currentPage;
                              });

                            }
                        ),
                        Constants.kSmallBox,
                      ],
                    ),
                  ),
                ),
              ),
              Constants.kSmallBox,

              CustomBlueButton(
                onPressed: (){
                  if(page<2){
                    setState(() {
                      page++;
                      _pageController.animateToPage(
                          page,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOutCubic
                      );
                    });
                  }else{
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context)=>const LoginPage()
                        )
                    );
                  }
                },
                text: page!=2?"Next":"Done",
              ),
              Constants.kSmallBox,
            ],
          ),
        ),
      ),
    );
  }
}


