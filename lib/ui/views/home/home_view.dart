import 'package:expense_tracker/Models/ExpenseModel.dart';
import 'package:expense_tracker/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: getBackgroundColor(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Hello there!",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: getIconTextColor()),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      viewModel.toggleDarkMode();
                    },
                    child: Icon(
                      Icons.dark_mode_outlined,
                      size: 32,
                      color: getIconTextColor(),
                    ),
                  )
                ],
              ),
              verticalSpaceMedium,
              viewModel.expensesList.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: viewModel.expensesList.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            ExpenseModel expense =
                                viewModel.expensesList[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: getCardColor(),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              margin: EdgeInsets.only(bottom: 8),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${expense.title!}",
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: getIconTextColor(),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '\$${expense.amount!}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.green.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    verticalSpaceMedium,
                                    Row(children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.shade100,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          expense.category!,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue.shade900,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Column(
                                        children: [
                                          Text(
                                            '${DateFormat('yyyy-MM-dd').format(expense.timeStamp!)}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: getIconTextColor()),
                                          ),
                                        ],
                                      ),
                                    ]),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              viewModel
                                                  .deleteExpense(expense.id!);
                                            },
                                            child: const Icon(
                                              Icons.delete_outline_outlined,
                                              color: Colors.red,
                                            )),
                                        horizontalSpaceMedium,
                                        GestureDetector(
                                            onTap: () {
                                              viewModel.navigateToAddExpense(
                                                  expense);
                                            },
                                            child: Icon(
                                              Icons.mode_edit_sharp,
                                              color: getIconTextColor(),
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  : Expanded(
                      child: Center(
                          child: Text(
                        "No expense yet",
                        style: TextStyle(
                            color: getIconTextColor(),
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      )),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.getAllExpense();
  }
}
