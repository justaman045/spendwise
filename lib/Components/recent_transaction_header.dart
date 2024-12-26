import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:spendwise/Models/cus_transaction.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Screens/all_transactions.dart";
import "package:spendwise/Utils/theme.dart"; // Assuming colors and routes are defined here

// Compact header for recent transactions with "See All" button
class RecentTransactionHeader extends StatelessWidget {
  const RecentTransactionHeader({
    super.key,
    required this.bankTransactions,
  });

  final List<CusTransaction> bankTransactions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Today's Transactions",
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: MyAppColors.gradientColor,
            ),
            onPressed: () => Get.to(
              routeName: routes[4],
              () => const AllTransactions(
                pageTitle: "All Transactions this Month",
                chartTitle: "All Transactions from SMS this Month",
                chartType: "Transaction",
                thisMonth: true,
              ),
              transition: customTrans,
              curve: customCurve,
              duration: duration,
            ),
            child: Text(
              "See All..",
              style: TextStyle(
                fontSize: 15.sp,
                color: MyAppColors.normalColoredWidgetTextColorDarkMode,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
