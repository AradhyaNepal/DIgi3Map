import 'package:digi3map/common/widgets/custom_circular_indicator.dart';
import 'package:digi3map/screens/practice/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PracticeView extends StatefulWidget {
  MovieModel data;
  PracticeView({
    required this.data,
    Key? key}) : super(key: key);

  @override
  _PracticeViewState createState() => _PracticeViewState();
}

class _PracticeViewState extends State<PracticeView> {
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context)=>PracticeProvider(),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: size.height,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InnerChild(),
                Consumer<PracticeProvider>(
                  builder: (context,providerObject,child) {
                    return ElevatedButton(
                        onPressed: (){
                         Navigator.push(context, 
                          MaterialPageRoute(builder: (context)=>PracticeView(
                            data: MovieModel(values: providerObject.serverValue),
                          ))
                         );
                        },
                        child: Text("Extract Again")
                    );
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class MovieModel{
  String values;
  MovieModel(
  {
    required this.values,
}
      );
}
class InnerChild extends StatelessWidget {
  const InnerChild({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnotherInnerChild(),
    );
  }
}

class AnotherInnerChild extends StatelessWidget {
  const AnotherInnerChild({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PracticeProvider>(
      builder: (context,providerObject,child) {
        return Center(
          child: providerObject.isExtracting?
          CustomCircularIndicator():
          Text(
            providerObject.serverValue
          ),
        );
      }
    );
  }
}
