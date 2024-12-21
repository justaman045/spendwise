import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

    return openDatabase(path, version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  /// Creates the initial database structure.
  Future<void> _onCreate(Database db, int version) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();

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

    // Create ExpenseTypes table (only in onCreate for initial creation)
    await db.execute('''
      CREATE TABLE $expenseTypesTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      debugPrint("Testing Complete");
      // Create the ExpenseTypes table if it doesn't exist
      await db.execute('''
        ALTER TABLE $expenseTypesTable 
        ADD COLUMN amount REAL;
      ''');
    }
  }

  Future<String> exportDatabase() async {
    String backupPath ="";
    // Get the database path
    final databasesPath = await getDatabasesPath();
    final dbPath = join(databasesPath, 'spendwise.db');

    // Get the Downloads directory
    final downloadsDirectory = await getDownloadsDirectory();

    if (downloadsDirectory != null) {

      if(Platform.isAndroid){
        backupPath = join("/storage/emulated/0/Download", 'spendwise_backup.db');
      } else {
        backupPath = join(downloadsDirectory.path, 'spendwise_backup.db');
      }

      // Copy the database file
      await File(dbPath).copy(backupPath);
      debugPrint('Database copied to Downloads folder successfully!');
    } else {
      debugPrint('Could not access Downloads folder.');
    }
    return backupPath;
  }

  Future<void> importDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/spendwise.db';
    debugPrint(path);
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final file = result.files.first;
      if(file.path != null){
        if(_database != null){
          await _database!.close();
        }
        File(path).delete();
        File(file.path!).copy(join(path));
      }
    } else {
      // User canceled the file picker
    }


  }

  Future<int> getTotalEntryCount() async {
    final db = await database;

    // List of table names (replace with your actual table names)
    final tableNames = ['transactions', 'subscriptions', 'peopleBalance', 'expenseTypes'];

    int totalEntries = 0;

    for (final tableName in tableNames) {
      final result = await db.rawQuery('SELECT COUNT(*) FROM $tableName');
      final count = Sqflite.firstIntValue(result);
      totalEntries += count!;
    }

    return totalEntries;
  }


}
