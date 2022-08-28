import 'package:digi3map/common/classes/text_calculator.dart';
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class ProfileEditableDescriptionWidget extends StatefulWidget {
  final ValueNotifier<String> description;
  final TextStyle textStyle;
  final double boxConstraintHeight=50;
  final bool editable;
  final bool isMessage;
  const ProfileEditableDescriptionWidget({
    required this.description,
    this.isMessage=false,
    this.editable=true,
    this.textStyle=const TextStyle(),
    Key? key
  }) : super(key: key);

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
    description=widget.description.value;
    _textEditingController.text=widget.description.value;
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
            widget.isMessage?SizedBox():Text(
                'Description',
                style: Styles.opacityHeadingStyle
            ),
            widget.isMessage?SizedBox():const SizedBox(width: 10,),
            (!widget.editable || widget.isMessage)?SizedBox():IconButton(
              onPressed: (){
                if(forEditing){
                  if(_textEditingController.text.isEmpty){
                    return;
                  }
                  firstTime=true;
                  description=_textEditingController.text;
                  widget.description.value=description;
                  print("Editing Description Vlaue"+widget.description.value);
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
                  child: Text(
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
              ):const SizedBox()
            ],
          ),
        ),
      ],
    );
  }
}
