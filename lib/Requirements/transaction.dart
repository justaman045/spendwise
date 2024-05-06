import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

final SmsQuery query = SmsQuery();
List<Transaction> transactions = [];

class Transaction {
  final double amount;
  final DateTime dateAndTime;
  final String name;
  final String typeOfTransaction;
  final String expenseType;
  final int transactionReferanceNumber;

  Transaction({
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

final transactionss = [
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

List<Transaction> countTransactionsThisMonth(List<Transaction> transactions) {
  final currentMonth = DateTime.now().month;
  return transactions
      .where((transaction) => transaction.dateAndTime.month == currentMonth)
      .toList();
}

List<Transaction> allIncomeThisMonth(List<Transaction> transactions) {
  return transactions
      .where((transaction) => isIncomeForThisMonth(transaction))
      .toList();
}

List<Transaction> allExpenseThisMonth(List<Transaction> transactions) {
  return transactions
      .where((transaction) => isExpenseForThisMonth(transaction))
      .toList();
}

double totalExpenseThisMonth(List<Transaction> transactions) {
  final currentMonth = DateTime.now().month;
  double expense = 0;
  for (var element in transactions) {
    if (element.dateAndTime.month == currentMonth) {
      if (element.expenseType == "expense") {
        expense += element.amount;
      }
    }
  }
  return expense;
}

double totalIncomeThisMonth(List<Transaction> transactions) {
  final currentMonth = DateTime.now().month;
  double income = 0;
  for (var element in transactions) {
    if (element.dateAndTime.month == currentMonth) {
      if (element.expenseType == "income") {
        income += element.amount;
      }
    }
  }
  return income;
}

List<ExpenseData> expenseChart(List<Transaction> transactions) {
  final filteredTransactions = transactions
      .where((transaction) => transaction.expenseType == "expense")
      .toList();
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
  final int date;
  final int expense;

  ExpenseData(this.date, this.expense);
}

Future<List<Transaction>> querySmsMessages() async {
  // final message = await query.querySms(
  //   kinds: [
  //     SmsQueryKind.inbox,
  //     SmsQueryKind.sent,
  //   ],
  //   count: 50000,
  // );
  // debugPrint('sms inbox messages: ${message.length}');

  transactions = transactionss;

  // ------------------------------------------------Area to test my Code----------------------------------

  // final filteredMessages = filterBankTransactions(message);

  // filteredMessages.forEach((element) {
  //   // debugPrint(element.date.toString());
  //   debugPrint(element.body);
  // });

  // final testTrans = parseBankTransactions(filteredMessages);
  // ------------------------------------------------Area to test my Code----------------------------------

  return transactions;
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

// void parseBankTransactions(List bankMessages) {
//   final nameRegex = RegExp(r";.*\.");
//   final amountRegex = RegExp(r"R.*[0-9]*\.[0-9]+");
//   final accountNumberRegex = RegExp(r"Acct\s+([\w]+)");
//   final dateRegex = RegExp(r"on\s+([\w-]+)");
//   final transactionTypeRegex = RegExp(r"[A-Za-z]+.*\.");

//   bankMessages.forEach((element) {
//     // debugPrint(element.body);
//     Match? nameMatch = transactionTypeRegex.firstMatch(element.body);
//     // debugPrint(nameMatch?.group(0));
//   });
// }

// List<Transaction> parseBankTransactions(List messages) {
//   final transactionRegex = RegExp(
//     r"(?i)(?:\b(?:debited|credited)\b\s+for\s+Rs\s+([0-9,.]+)\)\s+on\s+([0-9]{2}-[A-Z]{3}-[0-9]{2})\s+([^\s]+(?:\s+[^\s]+)?)(?:\s+trf\s+to\s+([^\s]+))?(?:\s+Refno\s+([0-9]+))?(?:\s+.*)?",
//     caseSensitive: false,
//     multiLine: true,
//   );

//   final transactions = <Transaction>[];
//   for (final message in messages) {
//     final matches = transactionRegex.allMatches(message);
//     for (final match in matches) {
//       final amount = double.parse(match.group(1)!.replaceAll(",", ""));
//       final dateAndTime = DateTime.parse(match.group(2)!);
//       final name = match.group(3)!;
//       final typeOfTransaction =
//           match.group(1) == "debited" ? "Debit" : "Credit";
//       final expenseType = match.group(4);
//       final transactionReferanceNumber =
//           match.group(5) != null ? int.parse(match.group(5)!) : null;
//       transactions.add(Transaction(
//         amount: amount,
//         dateAndTime: dateAndTime,
//         name: name,
//         typeOfTransaction: typeOfTransaction,
//         expenseType: expenseType.toString(),
//         transactionReferanceNumber: transactionReferanceNumber?.toInt() != null
//             ? transactionReferanceNumber!.toInt()
//             : 0,
//       ));
//     }
//   }
//   return transactions;
// }

// Example usage:
// final messages = [
//   "ICICI Bank Acct XX692 debited for Rs 1021.00 on 04-Apr-24; Aman Kumar Ojha credited. UPI:446151474748. Call 18002662 for dispute. SMS BLOCK 692 to 9215676766.",
//   "Dear UPI user A/C X5488 debited by 156.0 on date 21Apr24 trf to K L SONS Refno 447860130589. If not u? call 1800111109. -SBI",
//   // Add more transaction messages here
// ];

// final transactions = searchTransactions(messages);

// // Display the extracted transactions
// for (final transaction in transactions) {
//   print("Amount: ${transaction.amount}");
//   print("Date and Time: ${transaction.dateAndTime}");
//   print("Name: ${transaction.name}");
//   print("Type of Transaction: ${transaction.typeOfTransaction}");
//   print("Expense Type: ${transaction.expenseType}");
//   print("Transaction Reference Number: ${transaction.transactionReferanceNumber}");
//   print("----------------------");
// }

