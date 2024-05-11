import 'dart:math';

import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:spendwise/Models/cus_transaction.dart';
import 'package:spendwise/Models/db_helper.dart';
import 'package:spendwise/Models/expense.dart';

final SmsQuery query = SmsQuery();
List<CusTransaction> transactions = [];

int generateUniqueRefNumber() {
  final currentTime = DateTime.now().millisecondsSinceEpoch;
  final random = Random();
  return currentTime * 1000 + random.nextInt(1000);
}

List<CusTransaction> allTodaysTransactions(List<CusTransaction> transaction) {
  final today = DateTime.now();
  return transaction
      .where((transaction) =>
          transaction.dateAndTime.month == today.month &&
          transaction.dateAndTime.day == today.day &&
          transaction.dateAndTime.year == today.year &&
          transaction.toInclude == 1)
      .toList();
}

bool isTransactionForThisMonth(CusTransaction transaction) {
  final today = DateTime.now();
  return transaction.dateAndTime.year == today.year &&
      transaction.dateAndTime.month == today.month &&
      transaction.toInclude == 1;
}

List<CusTransaction> allIncomeThisMonth(List<CusTransaction> transactions) {
  final today = DateTime.now();
  return transactions
      .where((transaction) =>
          transaction.dateAndTime.year == today.year &&
          transaction.dateAndTime.month == today.month &&
          transaction.typeOfTransaction == "income" &&
          transaction.toInclude == 1)
      .toList();
}

List<CusTransaction> allExpenseThisMonth(List<CusTransaction> transactions) {
  final today = DateTime.now();
  return transactions
      .where((transaction) =>
          transaction.dateAndTime.year == today.year &&
          transaction.dateAndTime.month == today.month &&
          transaction.typeOfTransaction == "expense" &&
          transaction.toInclude == 1)
      .toList();
}

List<CusTransaction> allaIncomeThisMonth(List<CusTransaction> transactions) {
  final today = DateTime.now();
  return transactions
      .where((transaction) =>
          transaction.dateAndTime.year == today.year &&
          transaction.dateAndTime.month == today.month &&
          transaction.typeOfTransaction == "income")
      .toList();
}

List<CusTransaction> allaExpenseThisMonth(List<CusTransaction> transactions) {
  final today = DateTime.now();
  return transactions
      .where((transaction) =>
          transaction.dateAndTime.year == today.year &&
          transaction.dateAndTime.month == today.month &&
          transaction.typeOfTransaction == "expense")
      .toList();
}

double totalExpenseThisMonth(List<CusTransaction> transactions) {
  final currentMonth = DateTime.now().month;
  double expense = 0;
  for (var element in transactions) {
    if (element.dateAndTime.month == currentMonth) {
      if (element.typeOfTransaction == "expense" && element.toInclude == 1) {
        expense += element.amount;
      }
    }
  }
  return expense;
}

double totalIncomeThisMonth(List<CusTransaction> transactions) {
  final currentMonth = DateTime.now().month;
  double income = 0;
  for (var element in transactions) {
    if (element.dateAndTime.month == currentMonth) {
      if (element.typeOfTransaction == "income" && element.toInclude == 1) {
        income += element.amount;
      }
    }
  }
  return income;
}

double totalAvailableBalance(List<CusTransaction> transactions) {
  double income = 0;
  for (var element in transactions) {
    if (element.typeOfTransaction == "income") {
      income += element.amount;
    } else if (element.typeOfTransaction == "expense") {
      income -= element.amount;
    }
  }
  return income;
}

List<ExpenseData> expenseChart(List<CusTransaction> transactions) {
  final filteredTransactions = transactions
      .where((transaction) => transaction.typeOfTransaction == "expense")
      .toList();
  return filteredTransactions.map((transaction) {
    final date = transaction.dateAndTime.day;
    final expense = transaction.amount.toInt();
    return ExpenseData(date, expense);
  }).toList();
}

List<ExpenseData> prepareChartData(List<CusTransaction> transactions) {
  return transactions.map((transaction) {
    final date = transaction.dateAndTime.day;
    final expense = transaction.amount.toInt();
    return ExpenseData(date, expense);
  }).toList();
}

Future<List<CusTransaction>> querySmsMessages() async {
  final message = await query.querySms(
    kinds: [
      SmsQueryKind.inbox,
      SmsQueryKind.sent,
    ],
    count: 50000,
  );

  // debugPrint(onlineTransactions.docs.toString());

  // transaction.map((onTrans) => debugPrint(onTrans.amount.toString()));

  final dbTransactions = await DatabaseHelper().getAllTransactions();

  // ------------------------------------------------Area to test my Code----------------------------------

  // final filteredMessages = filterBankTransactions(message);

  // filteredMessages.forEach((element) {
  //   // debugPrint(element.date.toString());
  //   debugPrint(element.body);
  // });

  // final testTrans = parseBankTransactions(filteredMessages);
  // ------------------------------------------------Area to test my Code----------------------------------

  return dbTransactions;
}

final bankTransactionRegex = RegExp(
  r'(?:debit|credit|transaction|payment|transfer)(?:\s+from|to)?(?:\s+INR|\$)(?:\d+(?:\.\d+)?)(?:\s+on|\sat)(?:\s+\d{2}:\d{2})?(?:\s+on\s+\d{2}/\d{2}/\d{4})?',
  caseSensitive: false,
);
final bankNameRegex = RegExp(
  r'(?:(?:ICICI|HDFC|Axis|SBI|Kotak|Bank of Baroda|Yes Bank|IDBI|PNB|Citibank|HSBC|Standard Chartered)(?: Bank)?)',
  caseSensitive: false,
);

List<SmsMessage> filterBankTransactions(List<SmsMessage> messages) {
  final filteredMessages = <SmsMessage>[];
  // debugPrint(messages.length.toString());
  for (final message in messages) {
    final body = message.body
        ?.toLowerCase(); // Convert to lowercase for case-insensitive matching

    // Check if the message contains bank-related keywords or matches the regular expressions
    if (body != null &&
        (bankTransactionRegex.hasMatch(body) || bankNameRegex.hasMatch(body))) {
      filteredMessages.add(message);
    }
  }
  return filteredMessages;
}
