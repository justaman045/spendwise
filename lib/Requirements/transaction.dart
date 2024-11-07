import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:spendwise/Models/cus_transaction.dart';
import 'package:spendwise/Models/expense.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Utils/transaction_methods.dart';

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
        .toList()
        .reversed
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
            transaction.typeOfTransaction.toLowerCase() ==
                typeOfTransaction[0] &&
            transaction.toInclude == 1)
        .toList()
        .reversed
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
            transaction.typeOfTransaction.toLowerCase() !=
                typeOfTransaction[0] &&
            transaction.toInclude == 1)
        .toList()
        .reversed
        .toList();
  } else if (income == true &&
      showHidden == true &&
      expense == false &&
      todayTrans == false &&
      thisMonth == false) {
    debugPrint("from incomeshowhidden");
    return transactions
        .where((transaction) =>
            transaction.typeOfTransaction.toLowerCase() == typeOfTransaction[0])
        .toList()
        .reversed
        .toList();
  } else if (expense == true &&
      showHidden == true &&
      thisMonth == false &&
      todayTrans == false &&
      income == false) {
    debugPrint("from expenseshowhidden");
    return transactions
        .where((transaction) =>
            transaction.typeOfTransaction.toLowerCase() != typeOfTransaction[0])
        .toList()
        .reversed
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
            transaction.expenseType != typeOfTransaction[0] &&
            transaction.toInclude == 1)
        .toList()
        .reversed
        .toList();
  } else if (thisMonth == true &&
      expense == false &&
      showHidden == false &&
      todayTrans == true &&
      income == false) {
    debugPrint("from todayTrans");
    return transactions
        .where((transaction) =>
            transaction.dateAndTime.month == today.month &&
            transaction.dateAndTime.year == today.year &&
            transaction.dateAndTime.day == today.day &&
            transaction.toInclude == 1)
        .toList()
        .reversed
        .toList();
  } else {
    // debugPrint(expense.toString());
    // debugPrint(showHidden.toString());
    debugPrint("from else");
    return transactions
        .where((transaction) =>
            transaction.dateAndTime.month == today.month &&
            transaction.dateAndTime.year == today.year &&
            transaction.toInclude == 1)
        .toList()
        .reversed
        .toList();
  }
}

double totalExpenseThisMonth(List<CusTransaction> transactions) {
  final currentMonth = DateTime.now().month;
  double expense = 0;
  for (var element in transactions) {
    if (element.dateAndTime.month == currentMonth) {
      if (element.typeOfTransaction.toLowerCase() != typeOfTransaction[0] &&
          element.toInclude == 1) {
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
      if (element.typeOfTransaction.toLowerCase() == typeOfTransaction[0] &&
          element.toInclude == 1) {
        income += element.amount;
      }
    }
  }

  return income;
}

double totalAvailableBalance(List<CusTransaction> transactions) {
  double income = 0;
  for (var element in transactions) {
    if (element.typeOfTransaction.toString().toLowerCase() == typeOfTransaction[0].toString().toLowerCase()) {
      income += element.amount;
    } else if (element.typeOfTransaction.toString().toLowerCase() != typeOfTransaction[0].toString().toLowerCase()) {
      income -= element.amount;
    }
  }
  return income;
}

//TODO: get overall income - overall expense ( not only this month )
double totalBalanceRemaining(List<CusTransaction> transactions) {
  double income = 0;
  for (var element in transactions) {
    if (element.typeOfTransaction.toLowerCase() == typeOfTransaction[0].toLowerCase()) {
      income += element.amount;
    } else if (element.typeOfTransaction.toLowerCase() != typeOfTransaction[0].toLowerCase()) {
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
          if (element.typeOfTransaction != typeOfTransaction[0] &&
              element.toInclude == 1) {
            expense += element.amount;
          }
        }
      }
      return expense;
    } else if (type.toLowerCase() == "totalIncomeThisMonth".toLowerCase()) {
      for (var element in transactions) {
        if (element.dateAndTime.month == currentMonth) {
          if (element.typeOfTransaction == typeOfTransaction[0] &&
              element.toInclude == 1) {
            expense += element.amount;
          }
        }
      }
      return expense;
    }
  }
  for (var element in transactions) {
    if (element.typeOfTransaction == typeOfTransaction[0]) {
      expense += element.amount;
    } else if (element.typeOfTransaction != typeOfTransaction[0]) {
      expense -= element.amount;
    }
  }
  return expense;
}

List<ExpenseData> expenseChart(List<CusTransaction> transactions) {
  final filteredTransactions = transactions
      .where((transaction) =>
          transaction.typeOfTransaction != typeOfTransaction[0])
      .toList();
  return filteredTransactions.map((transaction) {
    final date = transaction.dateAndTime.day;
    final expense = transaction.amount.toInt();
    return ExpenseData(date, expense);
  }).toList();
}

List<ExpenseData> prepareChartData(List<CusTransaction> transactions) {
  final Map<int, double> dayToTotalExpense = {}; // Map to store daily sums

  // Loop through transactions and accumulate daily sums
  for (final transaction in transactions) {
    final day = transaction.dateAndTime.day;
    final expense = transaction.amount.toInt();
    dayToTotalExpense[day] = (dayToTotalExpense[day] ?? 0) + expense;
  }

  // Create ExpenseData objects from the map
  return dayToTotalExpense.entries.map((entry) {
    final date = entry.key;
    final totalExpense = entry.value.toInt();
    return ExpenseData(date, totalExpense);
  }).toList();
}

Future<List<List<Object>>> querySmsMessages() async {
  // ------------------------------------------------Area to test my Code----------------------------------

  final responses = await Future.wait([
    TransactionMethods().getAllTransactions(),
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

List<CusTransaction> parseTransactionsFromSms(List<SmsMessage> messages) {
  final transactions = <CusTransaction>[];
  for (final message in messages) {
    final messageBody = message.body;
    if (messageBody == null) {
      continue; // Skip messages not from ICICI Bank
    }

    final transactionType =
        messageBody.contains('credited') ? 'Credit' : 'Debit';
    final amount =
        double.tryParse(messageBody.split('Rs ')[1].split('.')[0]) ?? 0.0;

    // Extract date using a regular expression (adapt if date format changes)
    final dateMatch = RegExp(r'\d{2}-\d{2}-\d{2}').firstMatch(messageBody);
    final dateString = dateMatch?.group(0);
    final dateTime = dateString != null
        ? DateTime.parse('$dateString 2024')
        : null; // Assuming year is 2024, adjust if needed

    // Extract name based on transaction type (heuristic approach)
    final name = transactionType == 'Credit'
        ? messageBody.split('credited.')[0].split(' ').last
        : messageBody.split('debited for')[1].split(' on')[0].trim();

    // No transaction reference number or expense type available from these messages
    const transactionRef = null;
    const expenseType = '';

    transactions.add(CusTransaction(
      amount: amount,
      dateAndTime: dateTime ?? DateTime.now(),
      name: name,
      typeOfTransaction: transactionType,
      expenseType: expenseType,
      transactionReferanceNumber: transactionRef,
    ));
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
