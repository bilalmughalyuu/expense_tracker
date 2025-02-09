import 'package:expense_tracker/Models/ExpenseModel.dart';
import 'package:expense_tracker/services/expense_service.dart';
import 'package:expense_tracker/ui/views/add_expense/add_expense_view.dart';
import 'package:expense_tracker/utils/DBHelper.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';

class HomeViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _expenseService = locator<ExpenseService>();

  List<ExpenseModel> get expensesList => _expenseService.getAllExpenses.value;
  bool get darkMode => _expenseService.darkMode.value;

  toggleDarkMode() {
    _expenseService.toggleDarkMode();
    notifyListeners();
  }

  getAllExpense() async {
    await _expenseService.getAllExpensesFun();
    notifyListeners();
  }

  deleteExpense(String id) async {
    final dbHelper = await DBHelper.init();

    await dbHelper.deleteExpense(id);
    await _expenseService.getAllExpensesFun();
    notifyListeners();
  }

  navigateToAddExpense(ExpenseModel expense) {
    _navigationService.navigateToView(AddExpenseView(
      expense: expense,
    ));
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_expenseService];
}
