import "package:countup/countup.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Requirements/transaction.dart";
import "package:spendwise/Screens/all_transactions.dart";

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
    // debugPrint((totalIncomeThisMonth(bankTransaction)).toString());
    return GestureDetector(
      onTap: () => Get.to(
        routeName: routes[5],
        () => const AllTransactions(
          pageTitle: "Monthly Transactions",
          chartTitle: "This months Transactions from SMS",
          chartType: "Transaction",
          type: "",
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
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromRGBO(210, 209, 254, 1),
                Color.fromRGBO(243, 203, 237, 1),
              ],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(20.w),
            ),
          ),
          // width: width,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(40.r),
              child: Column(
                children: [
                  Text(
                    "Available Balance",
                    style: TextStyle(
                      fontSize: 15.w,
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
                                      .toDouble() >
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
                                  0
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
