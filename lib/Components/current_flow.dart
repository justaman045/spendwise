import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:get/get.dart";
import "package:spendwise/Components/cash_flow.dart";
import "package:spendwise/Models/cus_transaction.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Requirements/transaction.dart";
import "package:spendwise/Screens/all_transactions.dart";

// TODO: Reduce Lines of Code
class CurrentFlow extends StatelessWidget {
  const CurrentFlow({
    super.key,
    required this.width,
    required this.bankTransactions,
  });

  final double width;
  final List<CusTransaction> bankTransactions;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => Get.to(
            routeName: "Monthly Income",
            () => const AllTransactions(
              type: "thismonthincome",
              pageTitle: "All Income this Month",
              chartTitle: "Income Read from SMS",
              chartType: "Income",
            ),
            transition: customTrans,
            curve: customCurve,
            duration: duration,
          ),
          child: CashFlow(
            width: width,
            flowText: "Income this Month",
            flowAmount: totalIncomeThisMonth(bankTransactions).toInt(),
          ),
        ),
        GestureDetector(
          onTap: () => Get.to(
            routeName: "Monthly Expense",
            () => const AllTransactions(
              type: "thismonthexpense",
              pageTitle: "All Expense this Month",
              chartTitle: "Expense Read from SMS",
              chartType: "Expense",
            ),
            transition: customTrans,
            curve: customCurve,
            duration: duration,
          ),
          child: CashFlow(
            width: width,
            flowText: "Expenses this Month",
            flowAmount: totalExpenseThisMonth(bankTransactions).toInt(),
          ),
        ),
      ],
    );
  }
}
