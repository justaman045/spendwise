import 'package:sqflite/sqflite.dart';

// TODO: Reduce Lines of Code
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
