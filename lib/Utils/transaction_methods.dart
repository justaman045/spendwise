// **Create (Insert)**
import 'package:spendwise/Models/cus_transaction.dart';
import 'package:spendwise/Models/db_helper.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:sqflite/sqflite.dart';

class TransactionMethods {
  Future<void> insertTransaction(CusTransaction transaction) async {
    final db = await DatabaseHelper().database;
    await db.insert(
      tableName,
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace on conflict
    );
  }

// **Read (Fetch All)**
  Future<List<CusTransaction>> getAllTransactions() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) => CusTransaction.fromMap(maps[i]));
  }

// **Read (Fetch One by Reference Number)**
  Future<CusTransaction?> getTransactionByRef(int refNumber) async {
    final db = await DatabaseHelper().database;
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
    final db = await DatabaseHelper().database;
    await db.update(
      tableName,
      transaction.toMap(),
      where: 'transactionReferanceNumber = ?',
      whereArgs: [transaction.transactionReferanceNumber],
    );
  }

// **Delete**
  Future<void> deleteTransaction(int refNumber) async {
    final db = await DatabaseHelper().database;
    await db.delete(
      tableName,
      where: 'transactionReferanceNumber = ?',
      whereArgs: [refNumber],
    );
  }
}
