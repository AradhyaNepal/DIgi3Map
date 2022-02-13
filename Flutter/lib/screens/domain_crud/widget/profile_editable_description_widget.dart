import 'package:digi3map/common/classes/TextCalculator.dart';
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class ProfileEditableDescriptionWidget extends StatefulWidget {
  final String description="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ut pulvinar lacus, a sodales purus. Donec sed dui ut libero vulputate porttitor. Donec eleifend feugiat volutpat. Nunc felis dui, convallis ut aliquam non";
  final TextStyle textStyle=TextStyle();
  final double boxConstraintHeight=50;
  ProfileEditableDescriptionWidget({Key? key}) : super(key: key);

  @override
  _ProfileEditableDescriptionWidgetState createState() => _ProfileEditableDescriptionWidgetState();
}

class _ProfileEditableDescriptionWidgetState extends State<ProfileEditableDescriptionWidget> {
  late String description;
  bool _loadMoreTextIsSelected=false;
  late TextCalculatorResult _textCalculatorResult;
  bool firstTime=true;
  bool forEditing=false;
  final TextEditingController _textEditingController=TextEditingController();
  @override
  void initState() {
    super.initState();
    description=widget.description;
    _textEditingController.text=widget.description;
  }
  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    if(firstTime){
      _textCalculatorResult=TextCalculator.textHeight(style:widget.textStyle,textWidth:size.width,text: description,constraintHeight: widget.boxConstraintHeight);
      firstTime=false;
    }
    bool showMoreLessAnimation=_textCalculatorResult.showMoreLessOptions;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Constants.kVerySmallBox,
        Row(
          children: [
            Text(
                'Description',
                style: Styles.opacityHeadingStyle
            ),
            SizedBox(width: 10,),
            IconButton(
              onPressed: (){
                if(forEditing){
                  if(_textEditingController.text.isEmpty){
                    return;
                  }
                  firstTime=true;
                  description=_textEditingController.text;
                }else{
                  _textEditingController.text=description;
                }
                forEditing=!forEditing;
                setState(() {});
              },
              icon: Icon(
                forEditing?Icons.save_alt_outlined:Icons.edit,
                color: ColorConstant.kIconColor,
              ),
            )
          ],
        ),

        forEditing?
            TextField(
              maxLines:_textCalculatorResult.constraintLines ,
              controller: _textEditingController,
              decoration: Styles.getDecorationWithLable("Edit"),
            ):
        GestureDetector(
          onTap: () {
            setState(() {
              _loadMoreTextIsSelected=!_loadMoreTextIsSelected;
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimatedSize(
                  alignment : Alignment.topLeft ,
                  curve: Curves.easeOutCubic,
                  duration: const Duration(milliseconds: 500),
                  child: new Text(
                    description,
                    maxLines: (showMoreLessAnimation==false || _loadMoreTextIsSelected)?150:_textCalculatorResult.constraintLines,
                    overflow: TextOverflow.ellipsis,
                    style: widget.textStyle,
                  )),
              showMoreLessAnimation?Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    _loadMoreTextIsSelected?"..less":"...more",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: ColorConstant.kBlueColor,
                    ),
                  ),
                ],
              ):SizedBox()
            ],
          ),
        ),
      ],
    );
  }
}
