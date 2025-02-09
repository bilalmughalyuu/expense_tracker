import 'package:expense_tracker/ui/common/app_colors.dart';
import 'package:expense_tracker/ui/views/add_expense/add_expense_view.dart';
import 'package:expense_tracker/ui/views/chart/chart_view.dart';
import 'package:expense_tracker/ui/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'root_viewmodel.dart';

class RootView extends StackedView<RootViewModel> {
  const RootView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RootViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: IndexedStack(
          index: viewModel.bottomNavIndex,
          children: <Widget>[
            HomeView(),
            AddExpenseView(),
            ChartView()
            // ExtraScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedLabelStyle: TextStyle(),
          type: BottomNavigationBarType.fixed,
          backgroundColor: getBackgroundColor(),
          selectedItemColor: getIconTextColor(),
          unselectedItemColor: getIconTextColor(),
          onTap: viewModel.changeTab,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                child: Icon(Icons.home),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Container(
                child: Icon(Icons.add),
              ),
              label: "Add Expense",
            ),
            BottomNavigationBarItem(
              icon: Container(
                child: Icon(Icons.insert_chart),
              ),
              label: "Chart",
            ),
          ],
        ));
  }

  @override
  RootViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RootViewModel();
}
