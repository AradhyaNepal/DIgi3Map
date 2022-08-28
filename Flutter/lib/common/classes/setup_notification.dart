import 'dart:convert';

import 'package:digi3map/data/services/services_names.dart';
import 'package:digi3map/screens/domain_list_graph/provider/domain_graph_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NotificationManager {

  NotificationManager();

  void sendNotification() async {
    await Future.delayed(Duration(seconds: 2));
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    print("I was in notification");
    String unbalancedNames = "";
    bool isUnbalanced = false;
    try {
      DomainGraphModel domainGraphModel =
          await DomainGraphProvider().getDomainGraph();
      for (int i = 0; i < domainGraphModel.yAxis.length; i++) {
        int points = domainGraphModel.yAxis[i];
        if (points > 30 || points < 20) {
          isUnbalanced = true;
          if (unbalancedNames.isNotEmpty)
            unbalancedNames = unbalancedNames + ",";
          unbalancedNames = unbalancedNames + domainGraphModel.xAxis[i];
        }
      }

      print(isUnbalanced);
      if (isUnbalanced) {


        BigTextStyleInformation bigTextStyleInformation =
        BigTextStyleInformation(
          '$unbalancedNames is Unbalanced. We have prepared best strategy to be balanced in these domains.',
          htmlFormatBigText: true,
          contentTitle: 'Domain Unbalanced',
          htmlFormatContentTitle: true,
          summaryText:  '$unbalancedNames is Unbalanced. We have prepared best strategy to be balanced in these domains.',
          htmlFormatSummaryText: true,
        );
        AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("4", "Domain Unbalanced",
            styleInformation: bigTextStyleInformation,
            icon: "ic_launcher"
        );
        NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
        await flutterLocalNotificationsPlugin.show(
            3,
            "Domain Unbalanced",
            '$unbalancedNames is Unbalanced. We have prepared best strategy to be balanced in these domains.',
            notificationDetails,
            payload: "Chain Is Going To Break");
      }

      final sharedPref = await SharedPreferences.getInstance();
      String token = sharedPref.getString(Service.tokenPrefKey) ?? "";
      Uri uri = Uri.parse(Service.baseApi + Service.getChainWhetherBroken);
      http.Response response =
          await http.get(uri, headers: {"Authorization": "Token $token"});
      final responseData = json.decode(response.body);
      if (responseData["chainBroken"]) {


        BigTextStyleInformation bigTextStyleInformation =
            BigTextStyleInformation(
              "Chain of ${responseData["brokenChainNames"]} is going to break. At least complete one small task to don't loose your points.",
            htmlFormatBigText: true,

            contentTitle: 'Chain Is Going To Break',
            htmlFormatContentTitle: true,
            summaryText:  "Chain of ${responseData["brokenChainNames"]} is going to break. At least complete one small task to don't loose your points.",
            htmlFormatSummaryText: true,
        );
        AndroidNotificationDetails androidNotificationDetails =
            AndroidNotificationDetails(
                "4", "Chain Broken",
                styleInformation: bigTextStyleInformation,
              icon: "ic_launcher"
            );
        NotificationDetails notificationDetails =
            NotificationDetails(
                android: androidNotificationDetails
            );
        await flutterLocalNotificationsPlugin.show(
            4, 'Chain Is Going To Break',
            "Chain of ${responseData["brokenChainNames"]} is going to break. At least complete one small task to don't loose your points.",
            notificationDetails,

            payload: "Chain Is Going To Break");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void selectNotification(
    String? payload,
  ) async {
    try {
      print("Clicked");
      // key.currentState!.push(
      //     MaterialPageRoute(builder: (_) => MainPage())
      //);
    } catch (e) {}
  }
}
