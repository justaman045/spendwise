import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:spendwise/Models/cus_transaction.dart';
import 'package:spendwise/Models/expense.dart';
import 'package:spendwise/Models/people_expense.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Utils/methods.dart';
import 'package:spendwise/Utils/people_balance_shared_methods.dart';
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
  if (showHidden) {
    if (expense) {
      return transactions
          .where((trans) =>
              (trans.typeOfTransaction.toLowerCase() ==
                  typeOfTransaction[1].toLowerCase()) ||
              (trans.typeOfTransaction.toLowerCase() ==
                  typeOfTransaction[2].toLowerCase()))
          .toList();
    }
    if (income) {
      return transactions
          .where((trans) => (trans.typeOfTransaction.toLowerCase() ==
              typeOfTransaction[0].toLowerCase()))
          .toList();
    }
  }

  if (!showHidden) {
    List<CusTransaction> nonHiddenTransaction =
        transactions.where((trans) => trans.toInclude == 1).toList();
    if (income && !thisMonth) {
      return nonHiddenTransaction
          .where((trans) =>
              trans.typeOfTransaction.toLowerCase() ==
              typeOfTransaction[0].toLowerCase())
          .toList();
    }
    if (expense && !thisMonth) {
      return nonHiddenTransaction
          .where((trans) =>
              (trans.typeOfTransaction.toLowerCase() ==
                  typeOfTransaction[1].toLowerCase()) ||
              (trans.typeOfTransaction.toLowerCase() ==
                  typeOfTransaction[2].toLowerCase()))
          .toList();
    }
    if (todayTrans) {
      return nonHiddenTransaction
          .where((trans) =>
              (trans.dateAndTime.day == DateTime.now().day) &&
              (trans.dateAndTime.month == DateTime.now().month) &&
              (trans.dateAndTime.year == DateTime.now().year))
          .toList();
    }
    if (thisMonth) {
      List<CusTransaction> nonHiddenThisMonthTransaction = nonHiddenTransaction
          .where((trans) =>
              (trans.dateAndTime.month == DateTime.now().month) &&
              (trans.dateAndTime.year == DateTime.now().year))
          .toList();

      if (income) {
        return nonHiddenThisMonthTransaction
            .where((trans) =>
                trans.typeOfTransaction.toLowerCase() ==
                typeOfTransaction[0].toLowerCase())
            .toList();
      }
      if (expense) {
        return nonHiddenThisMonthTransaction
            .where((trans) =>
                (trans.typeOfTransaction.toLowerCase() ==
                    typeOfTransaction[1].toLowerCase()) ||
                (trans.typeOfTransaction.toLowerCase() ==
                    typeOfTransaction[2].toLowerCase()))
            .toList();
      }

      return nonHiddenThisMonthTransaction;
    }
  }
  return transactions.where((trans) => trans.toInclude == 1).toList();
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
    if (element.typeOfTransaction.toString().toLowerCase() ==
        typeOfTransaction[0].toString().toLowerCase()) {
      income += element.amount;
    } else if (element.typeOfTransaction.toString().toLowerCase() !=
        typeOfTransaction[0].toString().toLowerCase()) {
      income -= element.amount;
    }
  }
  return income;
}

//TODO: get overall income - overall expense ( not only this month )
double totalBalanceRemaining(List<CusTransaction> transactions) {
  double income = 0;
  for (var element in transactions) {
    if (element.typeOfTransaction.toLowerCase() ==
        typeOfTransaction[0].toLowerCase()) {
      income += element.amount;
    } else if (element.typeOfTransaction.toLowerCase() !=
        typeOfTransaction[0].toLowerCase()) {
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

IconData getIconData(String typeOfExp) {
  debugPrint(typeOfExp);
  final defaultIcon = IconData(
    typeOfExp.substring(0, 1).toUpperCase().codeUnitAt(0),
  );

  // Check for predefined categories
  final predefinedIcons = {
    'food & groceries': const IconData(0xe532, fontFamily: 'MaterialIcons'),
    'transportation': const IconData(0xe1d5, fontFamily: 'MaterialIcons'),
    'entertainment': Icons.movie_filter_sharp,
    'rent/bills': Icons.money,
    'bills': Icons.money, // Consider a separate icon for bills if needed
    'personal care': Icons.personal_injury,
  };

  // Check for predefined categories first
  if (predefinedIcons.containsKey(typeOfExp.toLowerCase())) {
    return predefinedIcons[typeOfExp.toLowerCase()]!;
  }

  // If no match, return custom icon with initials
  return defaultIcon;
}

Future<bool> addIncomeAndExpense(
    String name,
    String amount,
    String typeOfExpense,
    String date,
    bool setCustomDate,
    String typeOfTransaction) async {
  //
  // Create the Transaction based on the Options
  CusTransaction transaction = CusTransaction(
    amount: double.parse(amount),
    dateAndTime: date.isEmpty ? DateTime.now() : stringToDateTime(date),
    name: name,
    typeOfTransaction: typeOfTransaction,
    expenseType: typeOfExpense,
    transactionReferanceNumber: generateUniqueRefNumber(),
  );

  // Insert the Transaction to Database
  await TransactionMethods().insertTransaction(transaction);

  // Search Database if the Transaction is Saved or not
  CusTransaction? testTransaction = await TransactionMethods()
      .getTransactionByRef(transaction.transactionReferanceNumber);

  // Confirm the Transaction, and if not then return Error
  if (testTransaction != null) {
    return true;
  } else {
    return false;
  }
}

Future<bool> addSharedIncomeAndExpense(
  String name,
  String amount,
  String typeOfExpense,
  String typeOfTransactionLocal,
  List<DropdownItem<String>> sharedNames,
  bool toExcludeYourself,
  String date,
  bool pastDateTransaction,
) async {
  // Create the Transaction based on the Options
  CusTransaction transaction = CusTransaction(
    amount: double.parse(amount),
    dateAndTime: !pastDateTransaction ? DateTime.now() : stringToDateTime(date),
    name: name,
    typeOfTransaction: typeOfTransactionLocal,
    expenseType: typeOfExpense,
    transactionReferanceNumber: generateUniqueRefNumber(),
  );

  // Insert the Transaction to Database
  if (transaction.typeOfTransaction.toLowerCase() ==
      typeOfTransaction[2].toLowerCase()) {
    await TransactionMethods().insertTransaction(transaction);
  }

  // Search Database if the Transaction is Saved or not
  CusTransaction? testTransaction = await TransactionMethods()
      .getTransactionByRef(transaction.transactionReferanceNumber);

  // Confirm the Transaction, and if not then return Error
  if ((testTransaction != null) ||
      ((transaction.typeOfTransaction.toLowerCase() ==
          typeOfTransaction[3].toLowerCase()))) {
    if (sharedNames.isNotEmpty) {
      List<PeopleBalance> peopleBalanceList =
          await PeopleBalanceSharedMethods().getAllPeopleBalance();
      for (DropdownItem dropdownItem in sharedNames) {
        for (PeopleBalance peopleBalance in peopleBalanceList) {
          debugPrint((dropdownItem.label.toLowerCase() ==
                  peopleBalance.name.toLowerCase())
              .toString());
          if (peopleBalance.name == dropdownItem.label) {
            await PeopleBalanceSharedMethods().insertPeopleBalance(
              PeopleBalance(
                name: peopleBalance.name,
                amount: transaction.typeOfTransaction.toLowerCase() ==
                        typeOfTransaction[2].toLowerCase()
                    ? double.parse(amount) /
                        (sharedNames.length + (toExcludeYourself ? 0 : 1))
                    : -(double.parse(amount) /
                        (sharedNames.length + (toExcludeYourself ? 0 : 1))),
                dateAndTime: DateFormat.yMMMMd()
                    .format(stringToDateTime(date))
                    .toString(),
                transactionFor: name,
                relationFrom: peopleBalance.relationFrom,
                transactionReferanceNumber:
                    transaction.transactionReferanceNumber,
              ),
            );
          }
        }
      }
    }
    return true;
  } else {
    return false;
  }
}
