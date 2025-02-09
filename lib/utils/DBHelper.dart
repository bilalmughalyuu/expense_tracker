import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static const ALL_EXPENSES = 'expenses';
  final BoxCollection collection;

  DBHelper._(this.collection);

  static Future<DBHelper> init() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final collection = await BoxCollection.open(
      'ExpenseTracker',
      {ALL_EXPENSES},
      path: '$path/expenseTracker.hive',
    );
    return DBHelper._(collection);
  }

  Future<CollectionBox<String>> getExpensesBox() async {
    return await collection.openBox<String>(ALL_EXPENSES);
  }

  Future<void> addExpense(String id, String expense) async {
    final expensesBox = await getExpensesBox();
    await expensesBox.put(id, expense);
  }

  Future<Map<String, String>> getAllExpenses() async {
    final expensesBox = await getExpensesBox();
    final allExpenses = await expensesBox.getAllValues();
    return allExpenses;
  }

  Future<String?> getExpense(String id) async {
    final expensesBox = await getExpensesBox();
    return await expensesBox.get(id);
  }

  Future<void> updateExpense(String id, String updatedExpense) async {
    final expensesBox = await getExpensesBox();
    await expensesBox.put(id, updatedExpense);
  }

  Future<void> deleteExpense(String id) async {
    final expensesBox = await getExpensesBox();
    await expensesBox.delete(id);
  }

  Future<void> clearAllExpenses() async {
    final expensesBox = await getExpensesBox();
    await expensesBox.clear();
  }

  Future<void> performTransaction() async {
    final expensesBox = await getExpensesBox();
    await collection.transaction(() async {
      await expensesBox.put(
          'expense1',
          jsonEncode({
            'title': 'Groceries',
            'amount': 100.0,
            'category': 'Food',
            'date': DateTime.now().toString()
          }));
      await expensesBox.put(
          'expense2',
          jsonEncode({
            'title': 'Gas',
            'amount': 50.0,
            'category': 'Transport',
            'date': DateTime.now().toString()
          }));
    }, boxNames: [ALL_EXPENSES]);
  }
}
