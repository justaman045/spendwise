import 'package:spendwise/Models/db_helper.dart';
import 'package:spendwise/Models/expense_type.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:sqflite/sqflite.dart'; // Assuming ExpenseType class exists

class ExpenseTypeMethods {
  // Create (Insert)
  Future<void> createExpenseType(ExpenseType expenseType) async {
    final db = await DatabaseHelper().database;
    await db.insert(
      expenseTypesTable,
      expenseType.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Read (Fetch All)
  Future<List<ExpenseType>> getAllExpenseTypes() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query(expenseTypesTable);
    return List.generate(maps.length, (i) => ExpenseType.fromMap(maps[i]));
  }

  // Read (Fetch One by ID) - Assuming ID is the primary key
  Future<ExpenseType?> getExpenseTypeById(int id) async {
    final db = await DatabaseHelper().database;
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
    final db = await DatabaseHelper().database;
    await db.update(
      expenseTypesTable,
      expenseType.toMap(),
      where: 'id = ?',
      whereArgs: [expenseType.id],
    );
  }

  // Delete
  Future<void> deleteExpenseType(int id) async {
    final db = await DatabaseHelper().database;
    await db.delete(
      expenseTypesTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Search by name
  Future<ExpenseType> searchExpenseTypesByName(String name) async {
    final db = await DatabaseHelper().database;
    final maps = await db
        .query(expenseTypesTable, where: 'name LIKE ?', whereArgs: ['%$name%']);
    return maps.map((map) => ExpenseType.fromMap(map)).toList().first;
  }
}
