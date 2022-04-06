
import 'package:digi3map/common/constants.dart';
import 'package:digi3map/common/widgets/custom_alert_dialog.dart';
import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/common/widgets/custom_snackbar.dart';
import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/study_page/provider/implementing_provider.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:digi3map/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImplementingWidget extends StatefulWidget {
  final ImplementingModel implementingModel;
  const ImplementingWidget({
    required this.implementingModel,
    Key? key,
  }) : super(key: key);

  @override
  State<ImplementingWidget> createState() => _ImplementingWidgetState();
}

class _ImplementingWidgetState extends State<ImplementingWidget> {
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
      child: Card(
        elevation: 5,
        color: ColorConstant.kGreyCardColor,
        margin: const EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Card(
                      margin: const EdgeInsets.all(0),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Image.asset(
                          widget.implementingModel.image,
                        ),
                      ),
                    ) ,
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                '${widget.implementingModel.id}) ${widget.implementingModel.name}',
                                style: Styles.mediumHeading,
                              ),
                            ),
                            IconButton(
                              onPressed: (){},
                              icon: Icon(
                                Icons.edit,
                                color: ColorConstant.kIconColor,
                              ),
                            )
                          ],
                        ),
                        Constants.kVerySmallBox,
                        Text(
                          '${widget.implementingModel.numberOfSets} Sets (${widget.implementingModel.restMinutes} Min Rest)',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline
                          ),
                        ),
                        for (int i=1;i<=widget.implementingModel.numberOfSets;i++)
                        Text(
                            "Set $i: ${widget.implementingModel.setsMinutes} min Study"
                        ),

                        Constants.kVerySmallBox,
                        isLoading?
                        Center(
                          child: CustomCircularIndicator(),
                        ):Consumer<ImplementingProvider>(
                          builder: (context,provider,child) {
                            return Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(primary: Colors.red),
                                      onPressed: (){
                                        showDialog(
                                            context: context,
                                            builder: (context){
                                              return  CustomAlertDialog(
                                                heading: "Give Up",
                                                subText:  "Do You Really Want To Give Up?",

                                              );
                                            }
                                        ).then((value) async{
                                          if(value==true){
                                            setState(() {
                                              isLoading=true;
                                            });
                                            try{
                                              await provider.addTransaction(widget.implementingModel.id);
                                              await provider.addImplementingPoints(skipped: true);

                                            }
                                            catch (e){
                                              CustomSnackBar.showSnackBar(context, e.toString());
                                            }

                                            setState(() {
                                              isLoading=false;
                                            });
                                          }
                                        });
                                      },
                                      child: Text("Failed")
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: (){

                                      },
                                      child: Text("Start")
                                  ),
                                ),
                              ],
                            );
                          }
                        )
                      ],
                    ),
                  ),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}
