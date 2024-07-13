import 'package:flutter/material.dart';
import 'package:spendwise/Models/cus_transaction.dart';
import 'package:sqflite/sqflite.dart';

// TODO: Reduce Lines of Code

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static const String tableName = 'transactions';
  static const String subscriptionsTable = 'subscriptions';
  static const String peopleBalanceTable = 'peopleBalance';
  static const String expenseTypesTable = 'expenseTypes';

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
          isActive BOOLEAN DEFAULT TRUE,
          recurringDate TEXT
        )
      ''');

      // Create PeopleBalance table
      db.execute('''
        CREATE TABLE $peopleBalanceTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          amount REAL NOT NULL,
          dateAndTime TEXT NOT NULL,
          transactionFor TEXT,
          relationFrom TEXT,
          transactionReferanceNumber INTEGER UNIQUE NOT NULL,
          FOREIGN KEY (transactionReferanceNumber) REFERENCES $tableName(transactionReferanceNumber)
        )
      ''');

      db.execute('''
    CREATE TABLE $expenseTypesTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL UNIQUE
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

  // Future<CusTransaction?> getTransactionByRef(int refNumber) async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps = await db.query(
  //     tableName,
  //     where: 'transactionReferanceNumber = ?',
  //     whereArgs: [refNumber],
  //   );
  //   if (maps.isNotEmpty) {
  //     return CusTransaction.fromMap(maps.first);
  //   }
  //   return null;
  // }

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
    debugPrint(subscription.name);
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

  // **Create (Insert)** PeopleBalance
  Future<void> insertPeopleBalance(PeopleBalance peopleBalance) async {
    final db = await database;
    await db.insert(
      peopleBalanceTable,
      peopleBalance.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace on conflict
    );
  }

  // **Read (Fetch All)** PeopleBalance
  Future<List<PeopleBalance>> getAllPeopleBalance() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(peopleBalanceTable);
    return List.generate(maps.length, (i) => PeopleBalance.fromMap(maps[i]));
  }

  // **Read (Fetch One by Reference Number)** PeopleBalance
  Future<PeopleBalance?> getPeopleBalanceByRef(int refNumber) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      peopleBalanceTable,
      where: 'transactionReferanceNumber = ?',
      whereArgs: [refNumber],
    );
    if (maps.isNotEmpty) {
      return PeopleBalance.fromMap(maps.first);
    }
    return null;
  }

  // **Update** PeopleBalance
  Future<void> updatePeopleBalance(PeopleBalance peopleBalance) async {
    final db = await database;
    await db.update(
      peopleBalanceTable,
      peopleBalance.toMap(),
      where: 'transactionReferanceNumber = ?',
      whereArgs: [peopleBalance.transactionReferanceNumber],
    );
  }

  // **Delete** PeopleBalance
  Future<void> deletePeopleBalance(int refNumber) async {
    final db = await database;
    await db.delete(
      peopleBalanceTable,
      where: 'transactionReferanceNumber = ?',
      whereArgs: [refNumber],
    );
  }

  // Create (Insert)
  Future<void> insertExpenseType(ExpenseType expenseType) async {
    final db = await database;
    await db.insert(
      expenseTypesTable,
      expenseType.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace on conflict
    );
  }

// Read (Fetch All)
  Future<List<ExpenseType>> getAllExpenseTypes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(expenseTypesTable);
    return List.generate(maps.length, (i) => ExpenseType.fromMap(maps[i]));
  }

// Read (Fetch One by ID)
  Future<ExpenseType?> getExpenseTypeById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      expenseTypesTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return ExpenseType.fromMap(maps.first);
    }
    return null;
  }

// Update
  Future<void> updateExpenseType(ExpenseType expenseType) async {
    final db = await database;
    await db.update(
      expenseTypesTable,
      expenseType.toMap(),
      where: 'id = ?',
      whereArgs: [expenseType.id],
    );
  }

// Delete
  Future<void> deleteExpenseType(int id) async {
    final db = await database;
    await db.delete(
      expenseTypesTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> isExpenseTypeNameExists(String expenseTypeName) async {
    final db = await database;
    final count = Sqflite.firstIntValue(await db.rawQuery(
      'SELECT COUNT(*) FROM $expenseTypesTable WHERE name = ?',
      [expenseTypeName],
    ));
    return count != null && count > 0;
  }
}

// Define your Subscription model class with corresponding fields
class Subscription {
  final int id;
  final String fromDate;
  final String toDate;
  final String recurringDate;
  final double amount;
  final String name;

  Subscription({
    required this.fromDate,
    required this.toDate,
    required this.amount,
    required this.name,
    required this.recurringDate,
    this.id = 0,
  });

  Map<String, dynamic> toMap() => {
        'fromDate': fromDate,
        'toDate': toDate,
        'amount': amount,
        'name': name,
        'recurringDate': recurringDate,
      };

  static Subscription fromMap(Map<String, dynamic> map) => Subscription(
        id: map['id'] as int,
        fromDate: map['fromDate'] as String,
        toDate: map['toDate'] as String,
        amount: map['amount'] as double,
        name: map['name'] as String,
        recurringDate: map['recurringDate'] as String,
      );
}

class PeopleBalance {
  final int id;
  final String name;
  final double amount;
  final String dateAndTime;
  final String
      transactionFor; // What the transaction is for (e.g., Rent, Groceries)
  final String
      relationFrom; // Who the transaction is from/to (e.g., Friend, Roommate)
  final int transactionReferanceNumber;

  PeopleBalance({
    required this.name,
    required this.amount,
    required this.dateAndTime,
    required this.transactionFor,
    required this.relationFrom,
    required this.transactionReferanceNumber,
    this.id = 0,
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'amount': amount,
        'dateAndTime': dateAndTime,
        'transactionFor': transactionFor,
        'relationFrom': relationFrom,
        'transactionReferanceNumber': transactionReferanceNumber,
      };

  static PeopleBalance fromMap(Map<String, dynamic> map) => PeopleBalance(
        id: map['id'] as int,
        name: map['name'] as String,
        amount: map['amount'] as double,
        dateAndTime: map['dateAndTime'] as String,
        transactionFor: map['transactionFor'] as String,
        relationFrom: map['relationFrom'] as String,
        transactionReferanceNumber: map['transactionReferanceNumber'] as int,
      );
}

class ExpenseType {
  final int id;
  final String name;

  ExpenseType({
    required this.name,
    this.id = 0,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };

  static ExpenseType fromMap(Map<String, dynamic> map) => ExpenseType(
        id: map['id'] as int,
        name: map['name'] as String,
      );
}
