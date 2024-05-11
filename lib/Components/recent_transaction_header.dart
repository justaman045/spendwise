import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:spendwise/Models/cus_transaction.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Screens/all_transactions.dart";

class RecentTransactionHeader extends StatelessWidget {
  const RecentTransactionHeader({
    super.key,
    required this.width,
    required this.bankTransactions,
  });

  final double width;
  final List<CusTransaction> bankTransactions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Today's Transaction",
            style: TextStyle(
              fontSize: 20.r,
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
                () => const AllTransactions(
                  type: "",
                  pageTitle: "All Transactions",
                  chartTitle: "All Transactions from SMS",
                  chartType: "Transaction",
                ),
                transition: customTrans,
                curve: customCurve,
                duration: duration,
              );
            },
            child: Text(
              "See All..",
              style: TextStyle(fontSize: 15.r),
            ),
          ),
        ],
      ),
    );
  }
}
