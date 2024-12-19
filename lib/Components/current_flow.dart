import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendwise/Components/cash_flow.dart'; // Assuming CashFlow is in this directory
import 'package:spendwise/Models/cus_transaction.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Requirements/transaction.dart';
import 'package:spendwise/Screens/all_transactions.dart';

// Displays income and expense summaries for the current month
class CurrentFlow extends StatelessWidget {
  const CurrentFlow({
    super.key,
    required this.bankTransactions,
  });

  final List<CusTransaction> bankTransactions;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Align items to the left
      children: [
        _buildCashFlowItem(
          onTap: () => Get.to(
            routeName: "Monthly Income",
            () => const AllTransactions(
              thisMonth: true,
              income: true,
              pageTitle: "All Income this Month",
              chartTitle: "Income Read from SMS",
              chartType: "Income",
            ),
            transition: customTrans,
            curve: customCurve,
            duration: duration,
          ),
          flowText: "Income this Month",
          flowAmount: totalIncomeThisMonth(
            allTransactions(bankTransactions, thisMonth: true, income: true),
          ).toInt(),
        ),
        _buildCashFlowItem(
          onTap: () => Get.to(
            routeName: "Monthly Expense",
            () => const AllTransactions(
              thisMonth: true,
              expense: true,
              pageTitle: "All Expense this Month",
              chartTitle: "Expense Read from SMS",
              chartType: "Expense",
            ),
            transition: customTrans,
            curve: customCurve,
            duration: duration,
          ),
          flowText: "Expenses this Month",
          flowAmount: totalExpenseThisMonth(
            allTransactions(bankTransactions, thisMonth: true, expense: true),
          ).toInt(),
        ),
      ],
    );
  }

  // Creates a CashFlow widget with tap handler, text, and calculated amount
  Widget _buildCashFlowItem({
    required VoidCallback onTap, // Callback for handling tap event
    required String flowText, // Text describing the cash flow type
    required int flowAmount, // Calculated amount
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CashFlow(
        flowText: flowText,
        flowAmount: flowAmount,
      ),
    );
  }
}
