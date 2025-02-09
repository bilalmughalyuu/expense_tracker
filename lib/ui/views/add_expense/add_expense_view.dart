import 'package:expense_tracker/Models/ExpenseModel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import 'add_expense_viewmodel.dart';

class AddExpenseView extends StackedView<AddExpenseViewModel> {
  final ExpenseModel? expense;
  const AddExpenseView({this.expense, Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddExpenseViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: getBackgroundColor(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: viewModel.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Visibility(
                          visible: expense != null,
                          child: GestureDetector(
                            onTap: () {
                              viewModel.goBack();
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: getIconTextColor(),
                            ),
                          )),
                      Text(
                        expense != null ? "Edit Expenses" : "Add Expenses",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: getIconTextColor()),
                      ),
                    ],
                  ),
                  verticalSpaceMedium,
                  Text(
                    "Enter title",
                    style: TextStyle(color: getIconTextColor()),
                  ),
                  TextFormField(
                    controller: viewModel.expenseTitle,
                    maxLines: 2,
                    style: TextStyle(color: getIconTextColor()),
                    decoration: InputDecoration(
                      hintText: "Enter Tittle",
                      hintStyle: TextStyle(color: getIconTextColor()),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter expense';
                      }
                      return null;
                    },
                  ),
                  verticalSpaceMedium,
                  Text(
                    "Enter Amount",
                    style: TextStyle(color: getIconTextColor()),
                  ),
                  TextFormField(
                    controller: viewModel.expenseAmount,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: getIconTextColor()),
                    decoration: InputDecoration(
                      hintText: 'Enter Amount',
                      hintStyle: TextStyle(color: getIconTextColor()),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter amount';
                      }
                      return null;
                    },
                  ),
                  verticalSpaceMedium,
                  Text(
                    "Select Category",
                    style: TextStyle(color: getIconTextColor()),
                  ),
                  DropdownButtonFormField(
                    hint: Text(
                      "Select an item",
                      style: TextStyle(color: getIconTextColor()),
                    ),
                    value: viewModel.selectedCategory,
                    style: TextStyle(color: getIconTextColor()),
                    dropdownColor: getBackgroundColor(),
                    iconEnabledColor: getIconTextColor(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: viewModel.categories.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(color: getIconTextColor()),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      viewModel.selectCategory(newValue);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select category';
                      }
                      return null;
                    },
                  ),
                  verticalSpaceMedium,
                  Text(
                    "Select Date",
                    style: TextStyle(color: getIconTextColor()),
                  ),
                  TextFormField(
                    controller: viewModel.expenseDate,
                    style: TextStyle(color: getIconTextColor()),
                    decoration: InputDecoration(
                      hintText: 'Select Date',
                      hintStyle: TextStyle(color: getIconTextColor()),
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              dialogBackgroundColor: Colors.black,
                              colorScheme: ColorScheme.light(),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  foregroundColor: kcBlackColor,
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );

                      if (pickedDate != null) {
                        viewModel.setSelectedDate(pickedDate);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select date';
                      }
                      return null;
                    },
                  ),
                  verticalSpaceMassive,
                  GestureDetector(
                    onTap: () {
                      viewModel.addExpense();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                          color: kcPrimaryColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          expense != null ? "Edit Expense" : "Add Expense",
                          style: const TextStyle(
                              color: kcWhiteColor, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  AddExpenseViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AddExpenseViewModel();

  @override
  void onViewModelReady(AddExpenseViewModel viewModel) {
    super.onViewModelReady(viewModel);
    if (expense != null) {
      viewModel.expense = expense!;
      viewModel.initScreen();
    }
  }
}
