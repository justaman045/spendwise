import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Requirements/transaction.dart";
import "package:spendwise/Screens/all_transactions.dart";

class RecentTransactionHeader extends StatelessWidget {
  const RecentTransactionHeader({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(width * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Today's Transaction",
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromRGBO(225, 225, 254, 1),
            ),
            onPressed: () {
              Get.to(
                routeName: routes[4],
                () => AllTransactions(
                  pageTitle: "All Transactions",
                  chartTitle: "All Transactions from SMS",
                  chartType: "Transaction",
                  transactioncustom: transactions,
                ),
                transition: customTrans,
                curve: customCurve,
                duration: duration,
              );
            },
            child: const Text(
              "See All..",
            ),
          ),
        ],
      ),
    );
  }
}
