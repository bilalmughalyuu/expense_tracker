import 'package:stacked/stacked.dart';

import '../../../Models/ExpenseModel.dart';
import '../../../app/app.locator.dart';
import '../../../services/expense_service.dart';

class ChartViewModel extends ReactiveViewModel {
  final _expenseService = locator<ExpenseService>();

  List<ExpenseModel> get expensesList =>
      _expenseService.getAllExpenses.value.reversed.toList();
  bool get darkMode => _expenseService.darkMode.value;

  getAllExpense() async {
    await _expenseService.getAllExpensesFun();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_expenseService];
}
