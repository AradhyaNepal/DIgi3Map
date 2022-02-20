import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/theme/colors.dart';
import 'package:flutter/material.dart';

class BasicEffect extends StatelessWidget {
  final String message;
  final String sender;
  final String time;
  final bool leftAlign;
  final normalRadius=const Radius.circular(10);
  final spikeRadius=const Radius.circular(2);
  final imageSize=50.0;

  const BasicEffect({
    required this.message,
    required this.sender,
    required this.time,
    this.leftAlign=true,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment:leftAlign?CrossAxisAlignment.start:CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment:leftAlign?MainAxisAlignment.start:MainAxisAlignment.end,
            children: [
              SizedBox(width: leftAlign?30:0,),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: leftAlign?ColorConstant.kMessageLeft:ColorConstant.kMessageRight,
                    borderRadius: BorderRadius.only(
                      topRight: normalRadius,
                      topLeft: normalRadius,
                      bottomRight: leftAlign?normalRadius:spikeRadius,
                      bottomLeft: leftAlign?spikeRadius:normalRadius,
                    )
                  ),
                  child: Column(
                    crossAxisAlignment:leftAlign?CrossAxisAlignment.start:CrossAxisAlignment.end,
                    children: [
                      Text(
                          message,
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      Text(
                        "18:30",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                          fontSize: 8,
                          color: Colors.white
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: leftAlign?0:30,),
            ],
          ),
          ClipOval(
            child: Image.asset(
              AssetsLocation.userDummyProfileLocation,
              height: 30,
              width: 30,
            ),
          )

        ],
      ),
    );
  }
}