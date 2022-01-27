import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/logo_widget.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/onBoarding/data/OnBoardingData.dart';
import 'package:digi3map/testing_all_navigation.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  height: 30,
                  child: FittedBox(child: LogoWidget())
                ),
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
                Container(
                  height: size.height*0.1,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: ColorConstant.kBlueColor),
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
                                  builder: (context)=>const TestingAllNavigation()
                              )
                          );
                        }
                      },
                      child: Text(page!=2?"Next":"Done")//page starts from 0
                  ),
                ),
                Constants.kSmallBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImagesForOnBoarding extends StatefulWidget {
  final PageController pageController;
  final Function(int) changedFunction;
  final int page;
  ImagesForOnBoarding({
    required this.pageController,
    required this.changedFunction,
    required this.page
  });
  final List<Widget> imagesWidget=[
    Image.asset(AssetsLocation.onBoarding1),
    Image.asset(AssetsLocation.onBoarding2),
    Image.asset(AssetsLocation.onBoarding3),
  ];


  @override
  _ImagesForOnBoardingState createState() => _ImagesForOnBoardingState();
}

class _ImagesForOnBoardingState extends State<ImagesForOnBoarding> {
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: size.height*0.4,
          width: size.width,
          child: PageView(
            physics: const BouncingScrollPhysics(),
            controller: widget.pageController,
            onPageChanged: widget.changedFunction,
            children:widget.imagesWidget,
          ),
        ),
        Constants.kSmallBox,
        Center(
          child: SmoothPageIndicator(
          controller: widget.pageController,
          count: 3,
          effect: ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: ColorConstant.kBlueColor,
            dotColor: ColorConstant.kBlueColor.withOpacity(0.2),
          ),
          ),
        ),
        Constants.kSmallBox,
        Text(
          OnBoardingData.dataList[widget.page].heading,
          textAlign: TextAlign.center,
          style: Styles.onBoardingHeading
        ),
        Constants.kSmallBox,
        Text(
          OnBoardingData.dataList[widget.page].value,
          style: Styles.onBoardingValue,
        ),

      ],
    );

  }
}
