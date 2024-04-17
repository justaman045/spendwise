import 'package:flutter/material.dart';
import 'package:spendwise/Requirements/transaction.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TransactionCharts extends StatelessWidget {
  const TransactionCharts(
      {super.key,
      required this.chartOne,
      required this.chartNameOne,
      required this.chartTitleCustom});

  final List<Transaction> chartOne;
  final String chartNameOne;
  final String chartTitleCustom;

  @override
  Widget build(BuildContext context) {
    final dataSource = prepareChartData(chartOne);
    return SfCartesianChart(
      primaryXAxis: const CategoryAxis(),
      title: ChartTitle(text: chartTitleCustom),
      legend: const Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CartesianSeries<ExpenseData, int>>[
        LineSeries<ExpenseData, int>(
          dataSource: dataSource,
          xValueMapper: (ExpenseData data, _) => data.date,
          yValueMapper: (ExpenseData data, _) => data.expense,
          name: chartNameOne,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}
