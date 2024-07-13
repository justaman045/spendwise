import 'package:sqflite/sqflite.dart';

/// Represents a customer transaction with associated data.
class CusTransaction {
  final double amount;
  final DateTime dateAndTime;
  final String name;
  final String typeOfTransaction;
  final String expenseType;
  final int transactionReferanceNumber;
  final int
      toInclude; // Flag to indicate if transaction should be included in calculations

  CusTransaction({
    required this.amount,
    required this.dateAndTime,
    required this.name,
    required this.typeOfTransaction,
    required this.expenseType,
    required this.transactionReferanceNumber,
    this.toInclude = 1, // Default to include
  });

  // Factory constructor to create a CusTransaction from a database map
  factory CusTransaction.fromMap(Map<String, dynamic> map) => CusTransaction(
        amount: map['amount'] as double,
        dateAndTime: DateTime.parse(map['dateAndTime'] as String),
        name: map['name'] as String,
        typeOfTransaction: map['typeOfTransaction'] as String,
        expenseType: map['expenseType'] as String,
        transactionReferanceNumber: map['transactionReferanceNumber'] as int,
        toInclude: map['toInclude'] == 0 ? 0 : 1, // Handle null or zero values
      );

  // Converts the CusTransaction object to a map for database insertion
  Map<String, dynamic> toMap() => {
        'amount': amount,
        'dateAndTime': dateAndTime.toString(),
        'name': name,
        'typeOfTransaction': typeOfTransaction,
        'expenseType': expenseType,
        'transactionReferanceNumber': transactionReferanceNumber,
        'toInclude': toInclude,
      };

  // Assuming you have a DatabaseHelper class (not shown here) that manages database operations

  // Inserts a transaction into the database
  static Future<void> insertTransaction(
      Database db, CusTransaction transaction) async {
    await db.insert(
      'transactions', // Replace 'transactions' with your actual table name
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace on conflict
    );
  }

  // Retrieves all transactions from the database
  static Future<List<CusTransaction>> getAllTransactions(Database db) async {
    final List<Map<String, dynamic>> maps = await db.query('transactions');
    return maps.map((map) => CusTransaction.fromMap(map)).toList();
  }

  // Retrieves a transaction by its reference number
  static Future<CusTransaction?> getTransactionByRef(
      Database db, int refNumber) async {
    final List<Map<String, dynamic>> maps = await db.query(
      'transactions',
      where: 'transactionReferanceNumber = ?',
      whereArgs: [refNumber],
    );
    return maps.isNotEmpty ? CusTransaction.fromMap(maps.first) : null;
  }

  // Updates an existing transaction in the database
  static Future<void> updateTransaction(
      Database db, CusTransaction transaction) async {
    await db.update(
      'transactions',
      transaction.toMap(),
      where: 'transactionReferanceNumber = ?',
      whereArgs: [transaction.transactionReferanceNumber],
    );
  }

  // Deletes a transaction from the database
  static Future<void> deleteTransaction(Database db, int refNumber) async {
    await db.delete(
      'transactions',
      where: 'transactionReferanceNumber = ?',
      whereArgs: [refNumber],
    );
  }
}
