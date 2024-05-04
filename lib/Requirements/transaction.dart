import "package:flutter/material.dart";

class Transaction {
  final int amount;
  final DateTime dateAndTime;
  final String name;
  final String typeOfTransaction;
  final String expenseType;
  final int transactionReferanceNumber; // New field

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
  return transaction.dateAndTime.year == today.year &&
      transaction.dateAndTime.month == today.month &&
      transaction.dateAndTime.day == today.day;
}

bool isTransactionForThisMonth(Transaction transaction) {
  final today = DateTime.now();
  return transaction.dateAndTime.year == today.year &&
      transaction.dateAndTime.month == today.month;
}

bool isExpenseForThisMonth(Transaction transaction) {
  final today = DateTime.now();
  return transaction.dateAndTime.year == today.year &&
      transaction.dateAndTime.month == today.month &&
      transaction.expenseType == "expense";
}

bool isIncomeForThisMonth(Transaction transaction) {
  final today = DateTime.now();
  return transaction.dateAndTime.year == today.year &&
      transaction.dateAndTime.month == today.month &&
      transaction.expenseType == "income";
}

int countTransactionsThisMonth() {
  final currentMonth = DateTime.now().month;
  // No change needed for counting all transactions this month
  return transactions
      .where((transaction) => transaction.dateAndTime.month == currentMonth)
      .length;
}

// Method to calculate total expense this month (considering expenseType)
double totalExpenseThisMonth() {
  final currentMonth = DateTime.now().month;
  return transactions
      .where((transaction) =>
          transaction.dateAndTime.month == currentMonth &&
          transaction.expenseType == "expense")
      .fold(0.0, (sum, transaction) => sum + transaction.amount.toDouble());
}

double totalIncomeThisMonth() {
  final currentMonth = DateTime.now().month;
  return transactions
      .where((transaction) =>
          transaction.dateAndTime.month == currentMonth &&
          transaction.expenseType == "income")
      .fold(0.0, (sum, transaction) => sum + transaction.amount.toDouble());
}

List<ExpenseData> expenseChart(List<Transaction> transactions) {
  final filteredTransactions = transactions.where((transaction) {
    return transaction.expenseType == "expense";
  }).toList();

  return filteredTransactions.map((transaction) {
    final date = transaction.dateAndTime.day;
    final expense = transaction.amount.toInt();

    return ExpenseData(date, expense);
  }).toList();
}

List<ExpenseData> prepareChartData(List<Transaction> transactions) {
  return transactions.map((transaction) {
    final date = transaction.dateAndTime.day;
    final expense = transaction.amount.toInt();

    return ExpenseData(date, expense);
  }).toList();
}

class ExpenseData {
  ExpenseData(this.date, this.expense);

  final int date;
  final int expense;
}
