import "package:countup/countup.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:spendwise/Models/cus_transaction.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Requirements/transaction.dart";
import "package:spendwise/Screens/all_transactions.dart";
import "package:spendwise/Utils/theme.dart";

// TODO: Reduce Lines of Code
class AvailableBalance extends StatelessWidget {
  const AvailableBalance({
    super.key,
    required this.width,
    required this.bankTransaction,
  });

  final double width;
  final List<CusTransaction> bankTransaction;

  @override
  Widget build(BuildContext context) {
    // GestureDetector to run a function when a certain gesture is detected over this widget
    return GestureDetector(
      onTap: () => Get.to(
        routeName: routes[5],
        () => const AllTransactions(
          pageTitle: "Monthly Transactions",
          chartTitle: "This months Transactions from SMS",
          chartType: "Transaction",
          type: "thisMonthTransactions",
        ),
        transition: customTrans,
        curve: customCurve,
        duration: duration,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 10.w,
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: MyAppColors.avaiableBalanceColor,
            borderRadius: BorderRadius.all(
              Radius.circular(20.w),
            ),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(40.r),
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
                          color: (totalIncomeThisMonth(bankTransaction) -
                                          totalExpenseThisMonth(
                                              bankTransaction))
                                      .toDouble() >=
                                  0
                              ? Colors.green
                              : Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Countup(
                        duration: duration,
                        begin: 0,
                        end: (totalIncomeThisMonth(bankTransaction) -
                                totalExpenseThisMonth(bankTransaction))
                            .toDouble(),
                        style: TextStyle(
                          fontSize: width * 0.12,
                          color: (totalIncomeThisMonth(bankTransaction) -
                                          totalExpenseThisMonth(
                                              bankTransaction))
                                      .toDouble() >
                                  -1
                              ? Colors.green
                              : Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      )
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
