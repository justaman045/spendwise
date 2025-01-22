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
  Future<List<PeopleBalance>?> getAllPeopleBalanceByRef(int refNumber) async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query(
      peopleBalanceTable,
      where: 'transactionReferanceNumber = ?',
      whereArgs: [refNumber],
    );
    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) => PeopleBalance.fromMap(maps[i]));
    }
    return null;
  }

  // **Read (Fetch All Balance by Name)** PeopleBalance
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

  // **Read (Fetch All by Name)** PeopleBalance
  Future<List<PeopleBalance>> getPeopleNames() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps =
        await db.query(peopleBalanceTable, distinct: true, groupBy: "name");
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

  Future<List<PeopleBalance>> calculateFinalAmount(
      List<PeopleBalance> data) async {
    // Group data by name
    final Map<String, List<PeopleBalance>> groupedData = data
        .fold<Map<String, List<PeopleBalance>>>({},
            (Map<String, List<PeopleBalance>> acc, PeopleBalance item) {
      acc[item.name] = (acc[item.name] ?? []).toList()..add(item);
      return acc;
    });

    // Calculate final amount for each group
    final List<PeopleBalance> result = groupedData.entries.map((entry) {
      final name = entry.key;
      final transactions = entry.value;

      // Calculate total amount (considering both positive and negative values)
      final double totalAmount = transactions.fold<double>(
          0, (double sum, PeopleBalance item) => sum + item.amount.round());

      return PeopleBalance(
        name: name,
        amount: totalAmount,
        // Copy other relevant data from the first transaction
        dateAndTime: transactions.first.dateAndTime,
        transactionFor: transactions.first.transactionFor,
        relationFrom: transactions.first.relationFrom,
        transactionReferanceNumber:
            transactions.first.transactionReferanceNumber,
      );
    }).toList();

    return result;
  }

  Future<double> calculateFinalAmountSingleUser(
      List<PeopleBalance> transactions) async {
    // No need to group data by name as we're dealing with a single user

    // Calculate total amount (considering both positive and negative values)
    final double totalAmount = transactions.fold<double>(
        0.0, (double sum, PeopleBalance item) => sum + item.amount);

    return totalAmount;
  }
}
