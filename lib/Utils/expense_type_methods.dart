import 'package:spendwise/Models/db_helper.dart';
import 'package:spendwise/Models/expense_type.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseTypeMethods {
  // Create (Insert)
  Future<void> insertExpenseType(ExpenseType expenseType) async {
    final db = await DatabaseHelper().database;
    await db.insert(
      expenseTypesTable,
      expenseType.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace on conflict
    );
  }

  // Read (Fetch All)
  Future<List<ExpenseType>> getAllExpenseTypes() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query(expenseTypesTable);
    return List.generate(maps.length, (i) => ExpenseType.fromMap(maps[i]));
  }

  // Read (Fetch One by ID)
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

  Future<bool> isExpenseTypeNameExists(String expenseTypeName) async {
    final db = await DatabaseHelper().database;
    final count = Sqflite.firstIntValue(await db.rawQuery(
      'SELECT COUNT(*) FROM $expenseTypesTable WHERE name = ?',
      [expenseTypeName],
    ));
    return count != null && count > 0;
  }
}
