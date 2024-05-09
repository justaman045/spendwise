import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:sqflite/sqflite.dart';

final SmsQuery query = SmsQuery();
List<CusTransaction> transactions = [];

class CusTransaction {
  final double amount;
  final DateTime dateAndTime;
  final String name;
  final String typeOfTransaction;
  final String expenseType;
  final int transactionReferanceNumber;
  final int toInclude;

  CusTransaction({
    required this.amount,
    required this.dateAndTime,
    required this.name,
    required this.typeOfTransaction,
    required this.expenseType,
    required this.transactionReferanceNumber,
    this.toInclude = 1, // Set default value to true
  });

  // Factory constructor to create a CusTransaction from a Map (used for database results)
  factory CusTransaction.fromMap(Map<String, dynamic> map) => CusTransaction(
        amount: map['amount'] as double,
        dateAndTime: DateTime.parse(map['dateAndTime'] as String),
        name: map['name'] as String,
        typeOfTransaction: map['typeOfTransaction'] as String,
        expenseType: map['expenseType'] as String,
        transactionReferanceNumber: map['transactionReferanceNumber'] as int,
        toInclude:
            map['toInclude'] == 0 ? 0 : 1, // Handle null value with default
      );

  // Method to convert the CusTransaction object to a Map (used for database insertion)
  Map<String, dynamic> toMap() => {
        'amount': amount,
        'dateAndTime': dateAndTime.toString(),
        'name': name,
        'typeOfTransaction': typeOfTransaction,
        'expenseType': expenseType,
        'transactionReferanceNumber': transactionReferanceNumber,
        'toInclude': toInclude == 0 ? 0 : 1,
      };

  // Assuming you have a DatabaseHelper class (not shown here) that manages database operations

  // **Create (Insert)**
  static Future<void> insertTransaction(
      Database db, CusTransaction transaction) async {
    await db.insert(
      'transactions', // Replace 'transactions' with your actual table name
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace on conflict
    );
  }

  // **Read (Fetch All)**
  static Future<List<CusTransaction>> getAllTransactions(Database db) async {
    final List<Map<String, dynamic>> maps = await db.query('transactions');
    return List.generate(maps.length, (i) => CusTransaction.fromMap(maps[i]));
  }

  // **Read (Fetch One by Reference Number)**
  static Future<CusTransaction?> getTransactionByRef(
      Database db, int refNumber) async {
    final List<Map<String, dynamic>> maps = await db.query(
      'transactions',
      where: 'transactionReferanceNumber = ?',
      whereArgs: [refNumber],
    );
    if (maps.isNotEmpty) {
      return CusTransaction.fromMap(maps.first);
    }
    return null;
  }

  // **Update**
  static Future<void> updateTransaction(
      Database db, CusTransaction transaction) async {
    await db.update(
      'transactions',
      transaction.toMap(),
      where: 'transactionReferanceNumber = ?',
      whereArgs: [transaction.transactionReferanceNumber],
    );
  }

  // **Delete**
  static Future<void> deleteTransaction(Database db, int refNumber) async {
    await db.delete(
      'transactions',
      where: 'transactionReferanceNumber = ?',
      whereArgs: [refNumber],
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  static const String tableName = 'transactions';

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/spendwise.db';

    // Create the database table with the new 'toInclude' column
    final db = await openDatabase(path, onCreate: (db, version) {
      db.execute('''
        CREATE TABLE $tableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          amount REAL NOT NULL,
          dateAndTime TEXT NOT NULL,
          name TEXT NOT NULL,
          typeOfTransaction TEXT NOT NULL,
          expenseType TEXT,
          transactionReferanceNumber INTEGER UNIQUE NOT NULL,
          toInclude BOOLEAN DEFAULT TRUE  -- Add the new column with default value
        )
      ''');
    }, version: 1);
    return db;
  }

  // **Create (Insert)**
  Future<void> insertTransaction(CusTransaction transaction) async {
    final db = await database;
    await db.insert(
      tableName,
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace on conflict
    );
  }

  // **Read (Fetch All)**
  Future<List<CusTransaction>> getAllTransactions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) => CusTransaction.fromMap(maps[i]));
  }

  // **Read (Fetch One by Reference Number)**
  Future<CusTransaction?> getTransactionByRef(int refNumber) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'transactionReferanceNumber = ?',
      whereArgs: [refNumber],
    );
    if (maps.isNotEmpty) {
      return CusTransaction.fromMap(maps.first);
    }
    return null;
  }

  // **Update**
  Future<void> updateTransaction(CusTransaction transaction) async {
    final db = await database;
    await db.update(
      tableName,
      transaction.toMap(),
      where: 'transactionReferanceNumber = ?',
      whereArgs: [transaction.transactionReferanceNumber],
    );
  }

  // **Delete**
  Future<void> deleteTransaction(int refNumber) async {
    final db = await database;
    await db.delete(
      tableName,
      where: 'transactionReferanceNumber = ?',
      whereArgs: [refNumber],
    );
  }
}

int generateUniqueRefNumber() {
  // Combine current timestamp in milliseconds with a random number for uniqueness
  final currentTime = DateTime.now().millisecondsSinceEpoch;
  final random = Random();
  return currentTime * 1000 + random.nextInt(1000);
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
  CusTransaction(
    amount: 22600,
    dateAndTime: DateTime(2024, 5, 1, 7, 00),
    name: "Salary",
    typeOfTransaction: "Salary",
    expenseType: "income",
    transactionReferanceNumber: 548354912476,
  ),
  CusTransaction(
    amount: 5000,
    dateAndTime: DateTime(2024, 5, 3, 7, 00),
    name: "Credit Card Payment of ICIC Mine Credit Card",
    typeOfTransaction: "EMI",
    expenseType: "expense",
    transactionReferanceNumber: 548354912476,
  ),
  CusTransaction(
    amount: 5000,
    dateAndTime: DateTime(2024, 4, 3, 7, 00),
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

List<CusTransaction> allTodaysTransactions(List<CusTransaction> transaction) {
  final today = DateTime.now();
  return transaction
      .where((transaction) =>
          transaction.dateAndTime.month == today.month &&
          transaction.dateAndTime.day == today.day &&
          transaction.dateAndTime.year == today.year)
      .toList();
}

bool isTransactionForThisMonth(CusTransaction transaction) {
  final today = DateTime.now();
  return transaction.dateAndTime.year == today.year &&
      transaction.dateAndTime.month == today.month;
}

bool isExpenseForThisMonth(CusTransaction transaction) {
  final today = DateTime.now();
  return transaction.dateAndTime.year == today.year &&
      transaction.dateAndTime.month == today.month &&
      transaction.typeOfTransaction == "expense";
}

bool isIncomeForThisMonth(CusTransaction transaction) {
  final today = DateTime.now();
  return transaction.dateAndTime.year == today.year &&
      transaction.dateAndTime.month == today.month &&
      transaction.typeOfTransaction == "income";
}

List<CusTransaction> countTransactionsThisMonth(
    List<CusTransaction> transactions) {
  final currentMonth = DateTime.now().month;
  return transactions
      .where((transaction) => transaction.dateAndTime.month == currentMonth)
      .toList();
}

List<CusTransaction> allIncomeThisMonth(List<CusTransaction> transactions) {
  return transactions
      .where((transaction) => isIncomeForThisMonth(transaction))
      .toList();
}

List<CusTransaction> allExpenseThisMonth(List<CusTransaction> transactions) {
  return transactions
      .where((transaction) => isExpenseForThisMonth(transaction))
      .toList();
}

double totalExpenseThisMonth(List<CusTransaction> transactions) {
  final currentMonth = DateTime.now().month;
  double expense = 0;
  for (var element in transactions) {
    if (element.dateAndTime.month == currentMonth) {
      if (element.typeOfTransaction == "expense") {
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
      if (element.typeOfTransaction == "income") {
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

class ExpenseData {
  final int date;
  final int expense;

  ExpenseData(this.date, this.expense);
}

Future<List<CusTransaction>> querySmsMessages() async {
  final message = await query.querySms(
    kinds: [
      SmsQueryKind.inbox,
      SmsQueryKind.sent,
    ],
    count: 50000,
  );
  debugPrint('sms inbox messages: ${message.length}');

  // debugPrint(onlineTransactions.docs.toString());

  // transaction.map((onTrans) => debugPrint(onTrans.amount.toString()));

  final dbTransactions = await DatabaseHelper().getAllTransactions();

  transactions = transactionss;

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