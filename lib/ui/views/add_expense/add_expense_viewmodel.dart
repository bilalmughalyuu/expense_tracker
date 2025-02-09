import 'dart:convert';

import 'package:expense_tracker/utils/MethodHelpers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

import '../../../Models/ExpenseModel.dart';
import '../../../app/app.locator.dart';
import '../../../services/expense_service.dart';
import '../../../utils/DBHelper.dart';

class AddExpenseViewModel extends BaseViewModel {
  final _expenseService = locator<ExpenseService>();
  final _navigationService = locator<NavigationService>();

  final formKey = GlobalKey<FormState>();

  ExpenseModel? expense;

  initScreen() {
    if (expense != null) {
      expenseTitle.text = expense?.title ?? "";
      expenseAmount.text = expense?.amount ?? "";
      expenseDate.text = DateFormat('yyyy-MM-dd').format(expense!.timeStamp!);
      selectedCategory = expense?.category;
    }
  }

  TextEditingController expenseTitle = TextEditingController();
  TextEditingController expenseAmount = TextEditingController();
  TextEditingController expenseDate = TextEditingController();

  List<ExpenseModel> expensesList = [];

  List<String> categories = [
    "Food",
    "Travel",
    "Shopping",
    "Entertainment",
    "Health",
    "Education",
    "Bills",
    "Other"
  ];

  String? selectedCategory;

  selectCategory(String? category) {
    selectedCategory = category;
    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    expenseDate.text = formattedDate;
    notifyListeners();
  }

  addExpense() async {
    if (formKey.currentState!.validate()) {
      final dbHelper = await DBHelper.init();
      if (expense != null) {
        ExpenseModel expenseModel = ExpenseModel(
            id: expense!.id,
            title: expenseTitle.text.trim(),
            amount: expenseAmount.text.trim(),
            category: selectedCategory,
            timeStamp: DateFormat('yyyy-MM-dd').parse(expenseDate.text)
        );
        await dbHelper.updateExpense(expense!.id!, jsonEncode(expenseModel));
        _navigationService.back();
      } else {
        var uuid = Uuid();
        String id = uuid.v4();

        ExpenseModel expenseModel = ExpenseModel(
            id: id,
            title: expenseTitle.text.trim(),
            amount: expenseAmount.text.trim(),
            category: selectedCategory,
            timeStamp: DateFormat('yyyy-MM-dd').parse(expenseDate.text));

        await dbHelper.addExpense(id, jsonEncode(expenseModel));
        _expenseService.changeTab(0);
      }
      MethodHelpers.showFlushBar(
        tittle: "Success!",
        subTitle: expense != null
            ? "Expense edited successfully"
            : "Expense has been added successfully",
        color: Colors.green,
      );
      expenseTitle.clear();
      expenseAmount.clear();
      expenseDate.clear();
      selectedCategory = null;
      _expenseService.getAllExpensesFun();
    }
  }

  goBack() {
    _navigationService.back();
  }
}
