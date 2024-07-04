// Function to returive data from android msg and FireStore data
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/Models/cus_transaction.dart';
import 'package:spendwise/Requirements/transaction.dart';

Future<QuerySnapshot<Map<String, dynamic>>> getUser() async {
  final users = await FirebaseFirestore.instance.collection("Users").get();
  return users;
}

Future<List<CusTransaction>> getTransactions() async {
  final bankTransactions = await querySmsMessages();
  // final parsedmsg =
  //     parseTransactionsFromSms(bankTransactions[1] as List<SmsMessage>);
  // final bankTransaction = combineTransactions(
  //     bankTransactions[0] as List<CusTransaction>, parsedmsg);
  // for (dynamic trans in parsedmsg) {
  //   debugPrint(trans);
  // }
  return bankTransactions[0] as List<CusTransaction>;
}

class ThemeModeController extends GetxController {
  var themeMode = ThemeMode.system; // Initial theme mode

  void toggleThemeMode() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    update(); // Update the reactive variable to trigger rebuilds
  }
}

Future<List<String>> getSubscriptionApps() async {
  final jsonString =
      await rootBundle.loadString('assets/subscription_list.json');
  final List<dynamic> data = json.decode(jsonString);
  return data.cast<String>();
}

DateTime stringToDateTime(String dateString) {
  // Use intl package for parsing with specific format

  try {
    // Define the format for "Month Day, Year"
    DateFormat format = DateFormat("MMMM d, yyyy");
    return format.parse(dateString);
  } on FormatException catch (e) {
    // Handle parsing error (e.g., invalid format)
    debugPrint("Invalid date format: $e");
    return DateTime.now(); // Or throw an exception if desired
  }
}

Map<String, int> daysToMonths(int days) {
  // Approximate month length (adjust if needed)
  const double averageDaysPerMonth = 30.44;

  // Calculate whole months
  final double wholeMonths = days / averageDaysPerMonth;
  final int roundedMonths = wholeMonths.round();

  // Calculate remaining days
  final int remainingDays =
      days - (roundedMonths * averageDaysPerMonth).round();

  return {
    'months': roundedMonths,
    'remainingDays': remainingDays,
  };
}
