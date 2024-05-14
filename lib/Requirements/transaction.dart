import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/Models/cus_transaction.dart';
import 'package:spendwise/Models/db_helper.dart';
import 'package:spendwise/Models/expense.dart';

// TODO: Reduce Lines of Code
final SmsQuery query = SmsQuery();
List<CusTransaction> transactions = [];

int generateUniqueRefNumber() =>
    DateTime.now().millisecondsSinceEpoch * 1000 + Random().nextInt(1000);

List<CusTransaction> allTransactions(
  List<CusTransaction> transactions, {
  bool showHidden = false,
  bool income = false,
  bool thisMonth = false,
  bool expense = false,
  bool todayTrans = false,
}) {
  final today = DateTime.now();
  if (showHidden == true &&
      income == false &&
      thisMonth == false &&
      expense == false &&
      todayTrans == false) {
    debugPrint("from showhidden");
    return transactions
        .where((transaction) => transaction.toInclude == 1)
        .toList();
  } else if (thisMonth == true &&
      income == true &&
      expense == false &&
      todayTrans == false &&
      showHidden == false) {
    debugPrint("from thismonthincome");
    return transactions
        .where((transaction) =>
            transaction.dateAndTime.year == today.year &&
            transaction.dateAndTime.month == today.month &&
            transaction.typeOfTransaction == "income".toLowerCase() &&
            transaction.toInclude == 1)
        .toList();
  } else if (thisMonth == true &&
      expense == true &&
      todayTrans == false &&
      income == false &&
      showHidden == false) {
    debugPrint("from thismonthexpense");
    return transactions
        .where((transaction) =>
            transaction.dateAndTime.year == today.year &&
            transaction.dateAndTime.month == today.month &&
            transaction.typeOfTransaction == "expense".toLowerCase() &&
            transaction.toInclude == 1)
        .toList();
  } else if (income == true &&
      showHidden == true &&
      expense == false &&
      todayTrans == false &&
      thisMonth == false) {
    debugPrint("from incomeshowhidden");
    return transactions
        .where((transaction) =>
            transaction.typeOfTransaction == "income".toLowerCase())
        .toList();
  } else if (expense == true &&
      showHidden == true &&
      thisMonth == false &&
      todayTrans == false &&
      income == false) {
    debugPrint("from expenseshowhidden");
    return transactions
        .where((transaction) =>
            transaction.typeOfTransaction == "expense".toLowerCase())
        .toList();
  } else if (thisMonth == true &&
      expense == true &&
      showHidden == false &&
      todayTrans == false &&
      income == false) {
    debugPrint("from thismonthexpense");
    return transactions
        .where((transaction) =>
            transaction.dateAndTime.month == today.month &&
            transaction.dateAndTime.year == today.year &&
            transaction.toInclude == 1)
        .toList();
  } else {
    // debugPrint(expense.toString());
    // debugPrint(showHidden.toString());
    debugPrint("from else");
    return transactions
        .where((transaction) =>
            transaction.dateAndTime.month == today.month &&
            transaction.dateAndTime.day == today.day &&
            transaction.dateAndTime.year == today.year &&
            transaction.toInclude == 1)
        .toList();
  }
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

double totalTransactionsThisToday(List<CusTransaction> transactions) {
  final currentMonth = DateTime.now().month;
  double expense = 0;
  for (var element in transactions) {
    if (element.dateAndTime.month == currentMonth) {
      if (element.toInclude == 1) {
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

double getBalance(List<CusTransaction> transactions, {String type = ""}) {
  final currentMonth = DateTime.now().month;
  double expense = 0;
  if (type.isNotEmpty) {
    if (type.toLowerCase() == "totalExpenseThisMonth".toLowerCase()) {
      for (var element in transactions) {
        if (element.dateAndTime.month == currentMonth) {
          if (element.typeOfTransaction == "expense".toLowerCase() &&
              element.toInclude == 1) {
            expense += element.amount;
          }
        }
      }
      return expense;
    } else if (type.toLowerCase() == "totalIncomeThisMonth".toLowerCase()) {
      for (var element in transactions) {
        if (element.dateAndTime.month == currentMonth) {
          if (element.typeOfTransaction == "income".toLowerCase() &&
              element.toInclude == 1) {
            expense += element.amount;
          }
        }
      }
      return expense;
    }
  }
  for (var element in transactions) {
    if (element.typeOfTransaction == "income") {
      expense += element.amount;
    } else if (element.typeOfTransaction == "expense") {
      expense -= element.amount;
    }
  }
  return expense;
}

// TODO: give he total expense made per day
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

Future<List<List<Object>>> querySmsMessages() async {
  // ------------------------------------------------Area to test my Code----------------------------------

  final responses = await Future.wait([
    DatabaseHelper().getAllTransactions(),
    query.querySms(
      kinds: [
        SmsQueryKind.inbox,
        SmsQueryKind.sent,
      ],
      count: 50000,
    )
  ]);
  // ------------------------------------------------Area to test my Code----------------------------------

  return responses;
}

final bankTransactionRegex = RegExp(
  r'(?:debit|credit|transaction|payment|transfer)(?:\s+from|to)?(?:\s+INR|\$)(?:\d+(?:\.\d+)?)(?:\s+on|\sat)(?:\s+\d{2}:\d{2})?(?:\s+on\s+\d{2}/\d{2}/\d{4})?',
  caseSensitive: false,
);
final bankNameRegex = RegExp(
  r'(?:(?:ICICI|HDFC|Axis|SBI|Kotak|Bank of Baroda|Yes Bank|IDBI|PNB|Citibank|HSBC|Standard Chartered)(?: Bank)?)',
  caseSensitive: false,
);

List<CusTransaction> parseTransactions(List<SmsMessage> messages) {
  final bankTransactions =
      filterBankTransactions(messages.map((m) => m.body.toString()).toList());

  final transactions = <CusTransaction>[];

  for (final messageBody in bankTransactions) {
    final parts = messageBody.split(';'); // Split by ';' to separate details

    // Extract relevant information
    dynamic amount;
    dynamic date = DateTime.now();
    dynamic toFrom = "";
    dynamic typeOfTransaction = "";
    dynamic upiRefNo;
    dynamic isIncluded = true; // Assuming all transactions should be included

    // Extract relevant information
    // amount = double.tryParse(
    //         extractA(parts, 'Rs') ?? extractValue(parts, 'Rs.').toString()) ??
    //     0.0;
    try {
      amount = double.parse(extractAmount(parts, "Rs").toString());
    } catch (e) {
      try {
        amount = double.parse(extractAmount(parts, "Rs. ").toString());
      } catch (e) {
        try {
          amount = double.parse(extractAmount(parts, "by").toString());
        } catch (e) {
          amount = 0.0;
        }
      }
    }

    try {
      try {
        date = DateFormat.yMMMMd('en_US')
            .format(DateTime.parse(extractDate(parts, "on").toString()));
      } catch (e) {
        date = DateFormat.yMMMd('en_US')
            .format(DateTime.parse(extractDate(parts, "on").toString()));
      }
      debugPrint(date);
    } catch (e) {
      debugPrint(e.toString() + "0000000");
    }

    if (amount != 0) {
      transactions.add(CusTransaction(
        amount: amount,
        dateAndTime: DateTime.now(),
        name: toFrom.toString(),
        typeOfTransaction: typeOfTransaction.toString(),
        expenseType:
            '', // Expense type might not be available in all messages (set to empty string)
        transactionReferanceNumber:
            upiRefNo == null ? generateUniqueRefNumber() : int.parse(upiRefNo),
        toInclude: isIncluded == true ? 1 : 0,
      ));
    }
  }

  return transactions;
}

// Helper function to extract values based on keywords
String? extractAmount(List<String> parts, String keyword) {
  return parts[0].trim().split(keyword)[1].trim().split("on")[0].toString();
}

String? extractDate(List<String> parts, String keyword) {
  // debugPrint();
  String tdate = "";
  try {
    tdate =
        parts[0].trim().split(keyword)[1].trim().split("date")[1].toString();
  } catch (e) {
    tdate = parts[0].trim().split(keyword)[1].trim().toString();
  } finally {
    tdate = tdate.split(" ")[0];
  }
  return tdate;
  // return DateTime.now().toString();
}

List<String> filterBankTransactions(List<String> messages) {
  final bankKeywords = [
    'ICICI',
    'Bank',
    'Acct',
    'debited',
    'credited',
    'UPI',
    'SBI',
    'HDFC',
    'AXIS',
    'Yes Bank',
    'Kotak',
    'RBL',
  ];

  final filteredMessages = messages.where((message) {
    final lowerMessage = message.toLowerCase();
    return bankKeywords.any((keyword) => lowerMessage.contains(keyword));
  }).toList();

  return filteredMessages;
}

List<CusTransaction> combineTransactions(
    List<CusTransaction> list1, List<CusTransaction> list2) {
  // Use spread operator (...) to combine the lists
  final combinedList = [...list1, ...list2];

  // Optional: Sort the combined list based on date and time (assuming dateAndTime is a DateTime)
  combinedList.sort((a, b) => a.dateAndTime.compareTo(b.dateAndTime));

  return combinedList;
}
