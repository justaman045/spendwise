import 'package:spendwise/Models/db_helper.dart';
import 'package:spendwise/Models/people_expense.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:sqflite/sqflite.dart';

class PeopleBalanceSharedMethods {
  // **Create (Insert)** PeopleBalance
  Future<void> insertPeopleBalance(PeopleBalance peopleBalance) async {
    final db = await DatabaseHelper().database;
    await db.insert(
      peopleBalanceTable,
      peopleBalance.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace on conflict
    );
  }

  // **Read (Fetch All)** PeopleBalance
  Future<List<PeopleBalance>> getAllPeopleBalance() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query(peopleBalanceTable);
    return List.generate(maps.length, (i) => PeopleBalance.fromMap(maps[i]));
  }

  // **Read (Fetch One by Reference Number)** PeopleBalance
  Future<PeopleBalance?> getPeopleBalanceByRef(int refNumber) async {
    final db = await DatabaseHelper().database;
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
  // **Read (Fetch One by Reference Number)** PeopleBalance
  Future<List<PeopleBalance>> getPeopleBalanceByName(String name) async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query(
      peopleBalanceTable,
      where: 'name = ?',
      whereArgs: [name],
    );
    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) => PeopleBalance.fromMap(maps[i]));
    }
    return [];
  }

  // **Update** PeopleBalance
  Future<void> updatePeopleBalance(PeopleBalance peopleBalance) async {
    final db = await DatabaseHelper().database;
    await db.update(
      peopleBalanceTable,
      peopleBalance.toMap(),
      where: 'transactionReferanceNumber = ?',
      whereArgs: [peopleBalance.transactionReferanceNumber],
    );
  }

  // **Delete** PeopleBalance
  Future<void> deletePeopleBalance(int refNumber) async {
    final db = await DatabaseHelper().database;
    await db.delete(
      peopleBalanceTable,
      where: 'transactionReferanceNumber = ?',
      whereArgs: [refNumber],
    );
  }
}
