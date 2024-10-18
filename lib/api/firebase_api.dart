import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Screens/cash_entry.dart';
import 'package:spendwise/Screens/home_page.dart';
import 'package:spendwise/main.dart';
import 'package:get/get.dart';

@pragma('vm:entry-point')
  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    debugPrint(message.notification?.title);
    debugPrint(message.notification?.body);
    debugPrint(message.data.toString());
  }

@pragma('vm:entry-point')
  void handleMessage(RemoteMessage? message){
  if(message == null) return;
  debugPrint("");
  Get.offAllNamed(HomePage.homePageroute);
  Get.toNamed(AddCashEntry.route, arguments: message);
  }

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future initPushNotification() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
  FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
}

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();

    //TODO: to save this fcmToken in the Firebase DB
    debugPrint(fcmToken);

    initPushNotification();
  }
}