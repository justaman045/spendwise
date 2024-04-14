class Transaction {
  final int amount;
  final DateTime dateAndTime;
  final String name;
  final String typeOfTransaction;
  final String expenseType; // New field

  const Transaction({
    required this.amount,
    required this.dateAndTime,
    required this.name,
    required this.typeOfTransaction,
    required this.expenseType,
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
  ),
  Transaction(
    amount: 411,
    dateAndTime: DateTime(2024, 4, 14, 10, 00),
    name: "X Box PC Game Pass",
    typeOfTransaction: "Subscription",
    expenseType: "expense",
  ),
  Transaction(
    amount: 4500,
    dateAndTime: DateTime(2024, 4, 14, 10),
    name: "Maya Mishra",
    typeOfTransaction: "Family",
    expenseType: "income",
  ),
  Transaction(
    amount: 7000,
    dateAndTime: DateTime(2024, 3, 14, 10),
    name: "ICICI Mine Credit Card",
    typeOfTransaction: "EMI",
    expenseType: "expense",
  ),
  Transaction(
    amount: 5000,
    dateAndTime: DateTime(2024, 4, 13, 10),
    name: "Saloni",
    typeOfTransaction: "Friend",
    expenseType: "income",
  ),
  Transaction(
    amount: 5000,
    dateAndTime: DateTime(2024, 4, 14, 10),
    name: "Saloni",
    typeOfTransaction: "Friend",
    expenseType: "income",
  ),
];

bool isTransactionForToday(Transaction transaction) {
  final today = DateTime.now();
  return transaction.dateAndTime.year == today.year &&
      transaction.dateAndTime.month == today.month &&
      transaction.dateAndTime.day == today.day;
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
