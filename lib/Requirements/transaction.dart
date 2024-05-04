import "package:flutter/material.dart";
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

class Transaction {
  final int? amount; // Made nullable
  final DateTime? dateAndTime; // Made nullable
  final String? name; // Made nullable
  final String? typeOfTransaction;
  final String? expenseType;
  final int? transactionReferanceNumber; // Made nullable

  const Transaction({
    required this.amount,
    required this.dateAndTime,
    required this.name,
    required this.typeOfTransaction,
    required this.expenseType,
    required this.transactionReferanceNumber,
  });
}

class Account {
  final int accountNumber;
  final String bankName;
  final String bankUserName;

  Account({
    required this.accountNumber,
    required this.bankName,
    required this.bankUserName,
  });
}

final transactions = [
  // Existing transactions with "expenseType" added
  Transaction(
    amount: 22600,
    dateAndTime: DateTime(2024, 5, 1, 7, 00),
    name: "Salary",
    typeOfTransaction: "Salary",
    expenseType: "income",
    transactionReferanceNumber: 548354912476,
  ),
  Transaction(
    amount: 5000,
    dateAndTime: DateTime(2024, 5, 3, 7, 00),
    name: "Credit Card Payment of ICIC Mine Credit Card",
    typeOfTransaction: "EMI",
    expenseType: "expense",
    transactionReferanceNumber: 548354912476,
  ),
];

final accounts = [
  Account(
    accountNumber: 858647520,
    bankName: "PayTM Account",
    bankUserName: "Aman Ojha",
  ),
];

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

bool isTransactionForToday(Transaction transaction) {
  final today = DateTime.now();
  return transaction.dateAndTime?.year == today.year &&
      transaction.dateAndTime?.month == today.month &&
      transaction.dateAndTime?.day == today.day;
}

bool isTransactionForThisMonth(Transaction transaction) {
  final today = DateTime.now();
  return transaction.dateAndTime?.year == today.year &&
      transaction.dateAndTime?.month == today.month;
}

bool isExpenseForThisMonth(Transaction transaction) {
  final today = DateTime.now();
  return transaction.dateAndTime?.year == today.year &&
      transaction.dateAndTime?.month == today.month &&
      transaction.expenseType == "expense";
}

bool isIncomeForThisMonth(Transaction transaction) {
  final today = DateTime.now();
  return transaction.dateAndTime?.year == today.year &&
      transaction.dateAndTime?.month == today.month &&
      transaction.expenseType == "income";
}

int countTransactionsThisMonth() {
  final currentMonth = DateTime.now().month;
  // No change needed for counting all transactions this month
  return transactions
      .where((transaction) => transaction.dateAndTime?.month == currentMonth)
      .length;
}

// Method to calculate total expense this month (considering expenseType)
double totalExpenseThisMonth() {
  final currentMonth = DateTime.now().month;
  return transactions
      .where((transaction) =>
          transaction.dateAndTime?.month == currentMonth &&
          transaction.expenseType == "expense")
      .fold(0.0, (sum, transaction) => sum + transaction.amount!.toDouble());
}

double totalIncomeThisMonth() {
  final currentMonth = DateTime.now().month;
  return transactions
      .where((transaction) =>
          transaction.dateAndTime?.month == currentMonth &&
          transaction.expenseType == "income")
      .fold(0.0, (sum, transaction) => sum + transaction.amount!.toDouble());
}

List<ExpenseData> expenseChart(List<Transaction> transactions) {
  final filteredTransactions = transactions.where((transaction) {
    return transaction.expenseType == "expense";
  }).toList();

  return filteredTransactions.map((transaction) {
    final date = transaction.dateAndTime?.day;
    final expense = transaction.amount?.toInt();

    return ExpenseData(date!, expense!);
  }).toList();
}

List<ExpenseData> prepareChartData(List<Transaction> transactions) {
  return transactions.map((transaction) {
    final date = transaction.dateAndTime?.day;
    final expense = transaction.amount?.toInt();

    return ExpenseData(date!, expense!);
  }).toList();
}

class ExpenseData {
  ExpenseData(this.date, this.expense);

  final int date;
  final int expense;
}

Future<List<Transaction>> parseBankTransactions(
    List<SmsMessage> messages) async {
  List<Transaction> transactions = [];

  for (SmsMessage message in messages) {
    final amount = extractAmount(message.body);
    final date = extractDate(message.body);
    final referenceNumber = extractReferenceNumber(message.body);
    final debitCredit = extractDebitCredit(message.body);
    final name = extractName(message.body);

    if (amount != null && date != null) {
      transactions.add(Transaction(
        amount: amount.toInt(),
        dateAndTime: date,
        name: name ?? "", // Name might be null if not applicable
        typeOfTransaction:
            debitCredit ?? "debit", // Debit by default if not specified
        expenseType: "", // Expense type not provided in the SMS examples
        transactionReferanceNumber:
            referenceNumber ?? 0, // Reference number might be null
      ));
    }
  }

  return transactions;
}

double? extractAmount(String? message) {
  final amountMatch = amountPattern.firstMatch(message!);
  if (amountMatch != null) {
    return double.parse(amountMatch.group(1)!);
  }
  return null;
}

DateTime? extractDate(String? message) {
  final dateMatch = datePattern.firstMatch(message!);
  if (dateMatch != null) {
    final day = int.parse(dateMatch.group(1)!);
    final month = monthMap[dateMatch.group(2)!];
    final year = int.parse(dateMatch.group(3)!);
    return DateTime(year, month!, day);
  }
  return null;
}

int? extractReferenceNumber(String? message) {
  final refMatch = refPattern.firstMatch(message!);
  if (refMatch != null) {
    final referenceString = refMatch.group(1);
    if (referenceString != null) {
      try {
        return int.parse(referenceString);
      } catch (e) {
        // Handle the case where the extracted string cannot be parsed to int
        return null;
      }
    }
  }
  return null;
}

String? extractDebitCredit(String? message) {
  if (debitCreditPattern.hasMatch(message!)) {
    return "debit";
  } else if (creditPattern.hasMatch(message)) {
    return "credit";
  }
  return null;
}

String? extractName(String? message) {
  final nameMatch = namePattern.firstMatch(message!);
  return nameMatch?.group(1);
}

// Regular expressions used for parsing
final amountPattern = RegExp(r"debited by|for Rs (\d+\.\d+)");
final datePattern = RegExp(r"on (\d{2}-\w{3}-\d{2})");
final refPattern = RegExp(r"Refno|UPI:(\d+)");
final debitCreditPattern = RegExp(r"debited");
final creditPattern = RegExp(r"credited");
final namePattern = RegExp(r"; (.*?) credited");

// Month mapping for date parsing
final monthMap = {
  "Jan": 1,
  "Feb": 2,
  "Mar": 3,
  "Apr": 4,
  "May": 5,
  "Jun": 6,
  "Jul": 7,
  "Aug": 8,
  "Sep": 9,
  "Oct": 10,
  "Nov": 11,
  "Dec": 12,
};
