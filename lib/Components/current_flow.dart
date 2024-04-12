import "package:flutter/material.dart";
import "package:spendwise/Components/cash_flow.dart";

class CurrentFlow extends StatelessWidget {
  const CurrentFlow({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CashFlow(
          width: width,
          flowText: "Income",
          flowAmount: 22600,
        ),
        CashFlow(
          width: width,
          flowText: "Expenses",
          flowAmount: 18000,
        ),
      ],
    );
  }
}
