import 'package:expense_tracker/Models/UserModel.dart';
import 'package:expense_tracker/services/expense_service.dart';
import 'package:expense_tracker/utils/SharedPref.dart';
import 'package:stacked/stacked.dart';
import 'package:expense_tracker/app/app.locator.dart';
import 'package:expense_tracker/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _expenseService = locator<ExpenseService>();

  Future runStartupLogic() async {
    UserModel? userModel = await SharedPref().getUserData();
    bool? isDarkMode = await SharedPref().getIsDarkMode();
    _expenseService.setIsDarkMode(isDarkMode ?? false);

    if (userModel != null) {
      DateTime expiryTime =
          userModel.timeStamp!.add(const Duration(seconds: 86400));
      if (DateTime.now().isAfter(expiryTime)) {
        _navigationService.replaceWithLoginView();
      } else {
        _navigationService.replaceWithRootView();
      }
    } else {
      _navigationService.replaceWithLoginView();
    }
  }
}
