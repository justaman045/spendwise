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

final transactions = [
  // Existing transactions with "expenseType" added
  Transaction(
    amount: 320,
    dateAndTime: DateTime(2024, 3, 22, 10, 00),
    name: "Harshit Yadav",
    typeOfTransaction: "Friend",
    expenseType: "expense",
    transactionReferanceNumber: 548354912476,
  ),
  Transaction(
    amount: 411,
    dateAndTime: DateTime(2024, 4, 10, 10, 00),
    name: "X Box PC Game Pass",
    typeOfTransaction: "Subscription",
    expenseType: "expense",
    transactionReferanceNumber: 548354912476,
  ),
  Transaction(
    amount: 411,
    dateAndTime: DateTime(2024, 4, 20, 10, 00),
    name: "X Box PC Game Pass",
    typeOfTransaction: "Subscription",
    expenseType: "expense",
    transactionReferanceNumber: 548354912476,
  ),
  Transaction(
    amount: 4500,
    dateAndTime: DateTime(2024, 4, 11, 10),
    name: "Maya Mishra",
    typeOfTransaction: "Family",
    expenseType: "income",
    transactionReferanceNumber: 548354912476,
  ),
  Transaction(
    amount: 7000,
    dateAndTime: DateTime(2024, 3, 12, 10),
    name: "ICICI Mine Credit Card",
    typeOfTransaction: "EMI",
    expenseType: "expense",
    transactionReferanceNumber: 548354912476,
  ),
  Transaction(
    amount: 5000,
    dateAndTime: DateTime(2024, 4, 13, 10),
    name: "Saloni",
    typeOfTransaction: "Friend",
    expenseType: "income",
    transactionReferanceNumber: 548354912476,
  ),
  Transaction(
    amount: 5000,
    dateAndTime: DateTime(2024, 4, 17, 10),
    name: "Saloni",
    typeOfTransaction: "Friend",
    expenseType: "income",
    transactionReferanceNumber: 548354912476,
  ),
];

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
