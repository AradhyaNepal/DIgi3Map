import 'package:flutter/cupertino.dart';
class TextCalculatorResult{
  bool showMoreLessOptions;
  int constraintLines;
  TextCalculatorResult({required this.showMoreLessOptions,required this.constraintLines});
}
class TextCalculator{
  ///From : https://stackoverflow.com/questions/52659759/how-can-i-get-the-size-of-the-text-widget-in-flutter
  ///https://stackoverflow.com/questions/54091055/flutter-how-to-get-the-number-of-text-lines/57738556#57738556
  TextCalculator();
  static TextCalculatorResult textHeight({required TextStyle style,required double textWidth,required String text,required double constraintHeight}) {

    //To find how many lines can be used in provided constraint
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    double singleLineHeight = textPainter.size.height;
    double lineForOnePx=1/singleLineHeight;
    int lineForConstraintPx=(lineForOnePx*constraintHeight).toInt();

    //To find whether to display more less option or not
    final span = TextSpan(text: text, style: style);
    final tp = TextPainter(text: span, maxLines: lineForConstraintPx,textDirection:TextDirection.ltr );
    tp.layout(maxWidth: textWidth);
    bool exceeds=tp.didExceedMaxLines;
    return TextCalculatorResult(showMoreLessOptions: exceeds, constraintLines: lineForConstraintPx);


  }





}