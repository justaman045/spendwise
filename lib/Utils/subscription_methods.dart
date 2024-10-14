import 'package:flutter/material.dart';
import 'package:spendwise/Models/db_helper.dart';
import 'package:spendwise/Models/subscription.dart';
import 'package:spendwise/Requirements/data.dart';

class SubscriptionMethods {
  // Create (Insert)
  Future<void> insertSubscription(Subscription subscription) async {
    final db = await DatabaseHelper().database;
    await db.insert(subscriptionsTable, subscription.toMap());
  }

  // Read (Fetch All)
  Future<List<Subscription>> getAllSubscriptions() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query(subscriptionsTable);
    return List.generate(maps.length, (i) => Subscription.fromMap(maps[i]));
  }

  // Read (Fetch One by ID) - Assuming ID is the primary key
  Future<Subscription?> getSubscriptionById(int id) async {
    final db = await DatabaseHelper().database;
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
    final db = await DatabaseHelper().database;
    await db.update(
      subscriptionsTable,
      subscription.toMap(),
      where: 'id = ?',
      whereArgs: [subscription.id],
    );
  }

  // Delete
  Future<void> deleteSubscription(int id) async {
    final db = await DatabaseHelper().database;
    await db.delete(
      subscriptionsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
