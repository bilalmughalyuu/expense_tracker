import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../services/expense_service.dart';

class RootViewModel extends ReactiveViewModel {

  final _expenseService = locator<ExpenseService>();


  int get bottomNavIndex => _expenseService.bottomNavIndex.value;

  changeTab(int index) {
    _expenseService.changeTab(index);
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_expenseService];
}
