// Function to returive data from android msg and FireStore data
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:get/get.dart';
import 'package:spendwise/Models/cus_transaction.dart';
import 'package:spendwise/Requirements/transaction.dart';

Future<QuerySnapshot<Map<String, dynamic>>> getUser() async {
  final users = await FirebaseFirestore.instance.collection("Users").get();
  return users;
}

Future<List<CusTransaction>> getTransactions() async {
  final bankTransactions = await querySmsMessages();
  final parsedmsg = parseTransactions(bankTransactions[1] as List<SmsMessage>);
  final bankTransaction = combineTransactions(
      bankTransactions[0] as List<CusTransaction>, parsedmsg);
  for (dynamic trans in parsedmsg) {
    debugPrint(trans);
  }
  return bankTransaction;
}

class ThemeModeController extends GetxController {
  var themeMode = ThemeMode.system; // Initial theme mode

  void toggleThemeMode() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    update(); // Update the reactive variable to trigger rebuilds
  }
}
