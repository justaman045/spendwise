import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendwise/Models/cus_transaction.dart';
import 'package:spendwise/Models/expense.dart'; // Assuming ExpenseData is defined here
import 'package:spendwise/Requirements/transaction.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Represents a chart for transaction data
class TransactionCharts extends StatelessWidget {
  const TransactionCharts({
    super.key,
    required this.chartData,
    required this.chartName,
    required this.chartTitle,
  });

  final List<CusTransaction> chartData;
  final String chartName;
  final String chartTitle;

  @override
  Widget build(BuildContext context) {
    final dataSource =
        prepareChartData(chartData); // Assuming prepareChartData is defined

    return SizedBox(
      width: 350.w,
      height: 250.h,
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        title: ChartTitle(
          text: chartTitle,
          textStyle:
              TextStyle(fontSize: 10.sp), // Use sp for scalable font size
        ),
        legend: const Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<ExpenseData, int>>[
          LineSeries<ExpenseData, int>(
            dataSource: dataSource.toList(),
            xValueMapper: (ExpenseData data, _) => data.date,
            yValueMapper: (ExpenseData data, _) => data.expense,
            name: chartName,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}
