import 'dart:convert';

import 'package:expense_tracker/utils/SharedPref.dart';
import 'package:stacked/stacked.dart';

import '../Models/ExpenseModel.dart';
import '../utils/DBHelper.dart';

class ExpenseService with ListenableServiceMixin {
  ExpenseService() {
    listenToReactiveValues(
      [_getAllExpenses, bottomNavIndex, _darkMode],
    );
  }

  final ReactiveValue<List<ExpenseModel>> _getAllExpenses =
      ReactiveValue<List<ExpenseModel>>([]);
  ReactiveValue<List<ExpenseModel>> get getAllExpenses => _getAllExpenses;

  final ReactiveValue<int> _bottomNavIndex = ReactiveValue<int>(0);
  ReactiveValue<int> get bottomNavIndex => _bottomNavIndex;

  final ReactiveValue<bool> _darkMode = ReactiveValue<bool>(false);
  ReactiveValue<bool> get darkMode => _darkMode;

  toggleDarkMode() async {
    _darkMode.value = !_darkMode.value;
    await SharedPref().setIsDarkMode(_darkMode.value);
  }

  setIsDarkMode(bool value) async {
    _darkMode.value = value;
  }

  getAllExpensesFun() async {
    _getAllExpenses.value = [];
    final dbHelper = await DBHelper.init();

    Map<String, String> abc = await dbHelper.getAllExpenses();

    List<String> encodedExpenses = abc.values.toList();
    for (var expense in encodedExpenses) {
      ExpenseModel expenseModel = ExpenseModel.fromJson(jsonDecode(expense));
      _getAllExpenses.value.add(expenseModel);
    }

    _getAllExpenses.value.sort((a, b) => b.timeStamp!.compareTo(a.timeStamp!));

    notifyListeners();
  }

  changeTab(int index) {
    _bottomNavIndex.value = index;
    notifyListeners();
  }
}
