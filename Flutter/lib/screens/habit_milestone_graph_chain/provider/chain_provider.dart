import 'dart:convert';

import 'package:digi3map/common/classes/HttpException.dart';
import 'package:digi3map/data/services/services_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
class Chain{
  static int activatedChainIndex=-1;
  int count;
  Chain({required this.count});



}

class ChainProvider with ChangeNotifier{
  static const chainJsonValue="chain";
  static const isCurrentJsonValue="isCurrent";
  List<Chain> chainList=[];
  int habitId;
  int? chainCoin;
  bool isLoading=true;
  ChainProvider({required this.habitId,bool fromMileStone=true}){
    if(fromMileStone){
      getCoin();
      getChain();
    }

  }
  Future<int> getChain() async{
    Chain.activatedChainIndex=-1;
    isLoading=true;
    int currentIndex=-1;
    notifyListeners();
    Uri uri =Uri.parse(Service.baseApi+Service.chainApi+"$habitId/");
    http.Response response=await http.get(uri);
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(message: responseData.toString());
    chainList=[];
    for (int i=0;i<responseData.length;i++){
      chainList.add(Chain(count: responseData[i][chainJsonValue]));
      if(responseData[i][isCurrentJsonValue]){
        Chain.activatedChainIndex=i;
        currentIndex=i;
      }
    }


    isLoading=false;
    notifyListeners();
    if(currentIndex!=-1){
      try{
        return ((chainList[currentIndex].count/21)*100).toInt();
      }on RangeError{
        return 0;
      }

    }
    return 0;
  }


  static const String coinJson="coin";
  Future<void> getCoin() async{
    Uri uri =Uri.parse(Service.baseApi+Service.chainCoinApi+"$habitId/");
    http.Response response=await http.get(uri);
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(message: responseData.toString());

    chainCoin=responseData[coinJson];
    notifyListeners();
  }
}