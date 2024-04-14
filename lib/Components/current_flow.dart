import "package:flutter/material.dart";
import "package:spendwise/Components/cash_flow.dart";

class CurrentFlow extends StatelessWidget {
  const CurrentFlow({
    super.key,
    required this.width,
    required this.income,
    required this.expense,
  });

  final double width;
  final double income;
  final double expense;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CashFlow(
          width: width,
          flowText: "Income",
          flowAmount: income.toInt(),
        ),
        CashFlow(
          width: width,
          flowText: "Expenses",
          flowAmount: expense.toInt(),
        ),
      ],
    );
  }
}
