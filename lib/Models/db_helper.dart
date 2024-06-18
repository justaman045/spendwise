import 'package:flutter/material.dart';
import 'package:spendwise/Models/cus_transaction.dart';
import 'package:sqflite/sqflite.dart';

// TODO: Reduce Lines of Code (Already implemented)

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static const String tableName = 'transactions';
  static const String subscriptionsTable = 'subscriptions';

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/spendwise.db';

    final db = await openDatabase(path, onCreate: (db, version) {
      // Create Transactions table (existing logic)
      db.execute('''
        CREATE TABLE $tableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          amount REAL NOT NULL,
          dateAndTime TEXT NOT NULL,
          name TEXT NOT NULL,
          typeOfTransaction TEXT NOT NULL,
          expenseType TEXT,
          transactionReferanceNumber INTEGER UNIQUE NOT NULL,
          toInclude BOOLEAN DEFAULT TRUE
        )
      ''');

      // Create Subscriptions table
      db.execute('''
        CREATE TABLE $subscriptionsTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          fromDate TEXT NOT NULL,
          toDate TEXT NOT NULL,
          amount REAL NOT NULL,
          name TEXT NOT NULL,
          isActive BOOLEAN DEFAULT TRUE
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

  // Create (Insert)
  Future<void> insertSubscription(Subscription subscription) async {
    final db = await database;
    await db.insert(subscriptionsTable, subscription.toMap());
  }

  // Read (Fetch All)
  Future<List<Subscription>> getAllSubscriptions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(subscriptionsTable);
    return List.generate(maps.length, (i) => Subscription.fromMap(maps[i]));
  }

  // Read (Fetch One by ID) - Assuming ID is the primary key
  Future<Subscription?> getSubscriptionById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      subscriptionsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Subscription.fromMap(maps.first);
    }
    return null;
  }

  // Update
  Future<void> updateSubscription(Subscription subscription) async {
    final db = await database;
    await db.update(
      subscriptionsTable,
      subscription.toMap(),
      where: 'id = ?',
      whereArgs: [subscription.id],
    );
  }

  // Delete
  Future<void> deleteSubscription(int id) async {
    final db = await database;
    await db.delete(
      subscriptionsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

// Define your Subscription model class with corresponding fields
class Subscription {
  final int id;
  final String fromDate;
  final String toDate;
  final double amount;
  final String name;

  Subscription({
    required this.fromDate,
    required this.toDate,
    required this.amount,
    required this.name,
    this.id = 0,
  });

  Map<String, dynamic> toMap() => {
        'fromDate': fromDate,
        'toDate': toDate,
        'amount': amount,
        'name': name,
      };

  static Subscription fromMap(Map<String, dynamic> map) => Subscription(
        id: map['id'] as int,
        fromDate: map['fromDate'] as String,
        toDate: map['toDate'] as String,
        amount: map['amount'] as double,
        name: map['name'] as String,
      );
}
