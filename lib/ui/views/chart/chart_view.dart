import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../Models/ExpenseModel.dart';
import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import 'chart_viewmodel.dart';

class ChartView extends StackedView<ChartViewModel> {
  const ChartView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ChartViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: getBackgroundColor(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Expenses Chart",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: getIconTextColor()),
              ),
              verticalSpaceMedium,
              Expanded(
                child: BarChart(
                  BarChartData(
                    titlesData: FlTitlesData(
                      rightTitles: AxisTitles(),
                      topTitles: AxisTitles(),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: TextStyle(color: getIconTextColor(), fontSize: 10),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: TextStyle(color: getIconTextColor(), fontSize: 10),
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: true),
                    barGroups: _buildBarChartData(viewModel.expensesList),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  ChartViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ChartViewModel();

  List<BarChartGroupData> _buildBarChartData(List<ExpenseModel> expenses) {
    return expenses.map((expense) {
      String date = DateFormat('dd').format(expense.timeStamp!);
      return BarChartGroupData(
        x: int.tryParse(date) ?? 1,
        barRods: [
          BarChartRodData(
            toY: double.parse(expense.amount!),
            color: Colors.blue,
            width: 22,
            borderRadius: BorderRadius.zero,
          ),
        ],
      );
    }).toList();
  }
}
