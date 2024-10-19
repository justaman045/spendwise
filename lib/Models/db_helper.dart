import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:sqflite/sqflite.dart';

/// Singleton DatabaseHelper class to manage the app's database.
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/spendwise.db';

    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  /// Creates the initial database structure.
  Future<void> _onCreate(Database db, int version) async {
    // Create Transactions table
    await db.execute('''
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
    await db.execute('''
      CREATE TABLE $subscriptionsTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fromDate TEXT NOT NULL,
        toDate TEXT NOT NULL,
        amount REAL NOT NULL,
        name TEXT NOT NULL,
        isActive BOOLEAN DEFAULT TRUE,
        isRecurring TEXT NOT NULL,
        tenure TEXT NOT NULL
      )
    ''');

    // Create PeopleBalance table
    await db.execute('''
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

    // Create ExpenseTypes table
    await db.execute('''
      CREATE TABLE $expenseTypesTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE
      )
    ''');
  }
}
