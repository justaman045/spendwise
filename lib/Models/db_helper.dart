import 'package:flutter/material.dart';
import 'package:spendwise/Models/cus_transaction.dart';
import 'package:sqflite/sqflite.dart';

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
    debugPrint(transaction.toInclude.toString());
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
