// Function to returive data from android msg and FireStore data
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    debugPrint(e.message);
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

int getTenureInDays(String tenure) {
  Duration difference;
  switch (tenure) {
    case "1 Day":
      difference = const Duration(days: 1);
      break;
    case "3 Days":
      difference = const Duration(days: 3);
      break;
    case "1 Week":
      difference = const Duration(days: 7);
      break;
    case "28 Days":
      difference = const Duration(days: 28);
      break;
    case "1 Month":
      difference = const Duration(days: 30);
      break;
    case "56 Days":
      difference = const Duration(days: 56);
      break;
    case "2 Months":
      difference = const Duration(days: 60);
      break;
    case "84 Days":
      difference = const Duration(days: 84);
      break;
    case "3 Months":
      difference = const Duration(days: 90);
      break;
    case "4 Months":
      difference = const Duration(days: 120);
      break;
    case "6 Months":
      difference = const Duration(days: 180);
      break;
    case "8 Months":
      difference = const Duration(days: 240);
      break;
    case "1 Year":
      difference = const Duration(days: 365);
      break;
    default:
      difference = const Duration(days: 0);
  }

  return difference.inDays;
}

yearBuilder() => ({
      required year,
      decoration,
      isCurrentYear,
      isDisabled,
      isSelected,
      textStyle,
    }) {
      return Center(
        child: Container(
          decoration: decoration,
          height: 36,
          width: 72,
          child: Center(
            child: Semantics(
              selected: isSelected,
              button: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    year.toString(),
                    style: textStyle,
                  ),
                  if (isCurrentYear == true)
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(left: 5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.redAccent,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    };

dayBuilder(BuildContext context) => ({
      required date,
      textStyle,
      decoration,
      isSelected,
      isDisabled,
      isToday,
    }) {
      Widget? dayWidget;
      if (date.day % 3 == 0 && date.day % 9 != 0) {
        dayWidget = Container(
          decoration: decoration,
          child: Center(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Text(
                  MaterialLocalizations.of(context).formatDecimal(date.day),
                  style: textStyle,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 27.5),
                  child: Container(
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:
                          isSelected == true ? Colors.white : Colors.grey[500],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return dayWidget;
    };

List<DropdownMenuItem<String>> getDropDownMenuItems(List<String> listOfStrings){
  return listOfStrings
      .map(
        (e) => DropdownMenuItem(
      value: e,
      child: Text(
        toBeginningOfSentenceCase(e),
        style: TextStyle(
          fontSize: 13.r,
        ),
      ),
    ),
  )
      .toList();
}