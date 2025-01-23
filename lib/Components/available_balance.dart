import "package:countup/countup.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:spendwise/Models/cus_transaction.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Requirements/transaction.dart";
import "package:spendwise/Screens/all_transactions.dart";
import "package:spendwise/Utils/theme.dart";

class AvailableBalance extends StatelessWidget {
  const AvailableBalance({
    super.key,
    required this.width,
    required this.bankTransaction,
  });

  final double width;
  final List<CusTransaction> bankTransaction;

  double calculateBalance() {
    return totalBalanceRemaining(allTransactions(bankTransaction));
  }

  Color getTextColor(double balance) {
    return balance >= 0 ? Colors.green : Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    final double balance = calculateBalance();

    return GestureDetector(
      onTap: () => Get.to(
        routeName: routes[5],
        () => const AllTransactions(
          pageTitle: "Monthly Transactions",
          chartTitle: "This months Transactions from SMS",
          chartType: "Transaction",
          thisMonth: true,
        ),
        transition: customTrans,
        curve: customCurve,
        duration: duration,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Container(
          decoration: BoxDecoration(
            gradient: MyAppColors.avaiableBalanceColor,
            borderRadius: BorderRadius.all(Radius.circular(20.w)),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(30.r),
              child: Column(
                children: [
                  Text(
                    "Available Balance",
                    style: TextStyle(
                      fontSize: 15.w,
                      color: MyAppColors.normalColoredWidgetTextColorDarkMode,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Rs. ",
                        style: TextStyle(
                          fontSize: 25.r,
                          color: getTextColor(balance),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Countup(
                        duration: duration,
                        begin: 0,
                        end: balance,
                        style: TextStyle(
                          fontSize: width * 0.12,
                          color: getTextColor(balance),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
