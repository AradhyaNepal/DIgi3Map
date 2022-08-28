import 'package:digi3map/common/constants.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IconsCollectionWidget extends StatefulWidget {
  final List<Widget> iconsWidgetsList;
  final int columnNumber;
  final bool showMoreLessOption;
  IconsCollectionWidget({
    required this.iconsWidgetsList,
    required this.columnNumber,
    this.showMoreLessOption=false
  });

  @override
  State<IconsCollectionWidget> createState() => _IconsCollectionWidgetState();
}

class _IconsCollectionWidgetState extends State<IconsCollectionWidget> {
  bool showMore=false;
  @override
  Widget build(BuildContext context) {
    int totalItem=widget.iconsWidgetsList.length;
    double rowCountDouble=totalItem/widget.columnNumber;
    int partialRowsCount=rowCountDouble.toInt();
    bool haveExtra=(partialRowsCount-rowCountDouble)!=0;
    int totalRowsCount=partialRowsCount+(haveExtra?1:0);
    print("Total rows count: $totalRowsCount");
    final showMoreLessOption=widget.showMoreLessOption && totalRowsCount>3;//First programmer may don't want show more less option for some widget, second there might only be 4 rows so why to show that option
    return AnimatedSize(
      duration: const Duration(milliseconds: 1000),
      alignment : Alignment.topLeft ,
      curve: Curves.easeOutCubic,
      child: Column(
        children: [
          for(int i=0;i<((showMoreLessOption && showMore)?totalRowsCount:3);i++)
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for(int j=0;j<widget.columnNumber;j++)
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: j==0?7.5:0,left: j==0?0:7.5),
                            child: getWidgetFromList(i*widget.columnNumber+j),
                          )
                      )
                  ],
                ),
                SizedBox(height: 15,)
              ],
            ),
          showMoreLessOption?Constants.kMediumBox:SizedBox(),
          showMoreLessOption?
          GestureDetector(
            onTap: (){
              setState(() {
                showMore=!showMore;
              });
            },
            child: Row(
              children: [
                Text(
                  showMore?"Show Less Amenities":"Show More Amenities",
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: ColorConstant.kBlueColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 2),
                Icon(
                  showMore?Icons.keyboard_arrow_up_rounded:Icons.keyboard_arrow_down_rounded,
                  size: 22,
                  color: ColorConstant.kBlueColor,
                )
              ],
            ),
          ):SizedBox(),
        ],
      ),
    );
  }

  Widget getWidgetFromList(int index){
    try{
      return widget.iconsWidgetsList[index];
    }on RangeError{
      return SizedBox();
    }
  }
}
