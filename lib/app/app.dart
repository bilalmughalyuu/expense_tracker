import 'package:expense_tracker/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:expense_tracker/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:expense_tracker/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:expense_tracker/ui/views/signup/signup_view.dart';
import 'package:expense_tracker/ui/views/login/login_view.dart';
import 'package:expense_tracker/ui/views/home/home_view.dart';
import 'package:expense_tracker/ui/views/add_expense/add_expense_view.dart';
import 'package:expense_tracker/ui/views/root/root_view.dart';
import 'package:expense_tracker/ui/views/chart/chart_view.dart';
import 'package:expense_tracker/ui/views/chart/chart_view.dart';
import 'package:expense_tracker/ui/views/chart/chart_view.dart';
import 'package:expense_tracker/services/expense_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView),
    MaterialRoute(page: SignupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: AddExpenseView),
    MaterialRoute(page: RootView),
    MaterialRoute(page: ChartView),
    MaterialRoute(page: ChartView),
    MaterialRoute(page: ChartView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: ExpenseService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
