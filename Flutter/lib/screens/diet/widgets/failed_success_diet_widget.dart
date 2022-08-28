import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_alert_dialog.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/screens/diet/provider/diet_provider.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FailedSuccessDietWidget extends StatefulWidget {
  final String dietId;
  const FailedSuccessDietWidget({
    required this.dietId,
    Key? key,
  }) : super(key: key);

  @override
  State<FailedSuccessDietWidget> createState() => _FailedSuccessDietWidgetState();
}

class _FailedSuccessDietWidgetState extends State<FailedSuccessDietWidget> {
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return isLoading?Center(
      child: CustomCircularIndicator(),
    ):
    Consumer<DietProvider>(
      builder: (context,provider,child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (context){
                          return  CustomAlertDialog(
                            heading: "Failed",
                            subText:  "Do You Really Want To Give Up?",

                          );
                        }
                    ).then((value) {
                      if(value==true){
                        buttonPressed(true,provider);
                      }
                    });

                  },
                  child: Text(
                    "Failed",
                    style: Styles.smallHeading,
                  )
              ),
            ),

            Constants.kSmallBox,
            Expanded(
              child: ElevatedButton(
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (context){
                          return  CustomAlertDialog(
                            heading: "Completed",
                            subText:  "Had You Completed The Diet?",

                          );
                        }
                    ).then((value) {
                      if(value==true){
                        buttonPressed(false,provider);
                      }
                    });
                  },
                  child: Text(
                    "Done",
                    style: Styles.smallHeading,
                  )
              ),
            ),

          ],
        );
      }
    );
  }

  void buttonPressed(bool skipped,DietProvider provider) async{
    setState(() {
      isLoading=true;
    });
    try{
      await provider.addTransaction(widget.dietId);
      await provider.addDietPoints(skipped: skipped);
      setState(() {
        isLoading=false;
      });
    }catch(e){
      CustomSnackBar.showSnackBar(context, e.toString());
      setState(() {
        isLoading=false;
      });
    }
  }
}
