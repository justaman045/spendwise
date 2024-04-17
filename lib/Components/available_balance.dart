import "package:countup/countup.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Requirements/transaction.dart";
import "package:spendwise/Screens/all_transactions.dart";

class AvailableBalance extends StatelessWidget {
  const AvailableBalance({
    super.key,
    required this.width,
    required this.intakeamount,
    required this.expense,
  });

  final double width;
  final int intakeamount;
  final int expense;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
        routeName: routes[5],
        () => AllTransactions(
          pageTitle: "Monthly Transactions",
          chartTitle: "This months Transactions from SMS",
          chartType: "Transaction",
          transactioncustom:
              transactions.where(isTransactionForThisMonth).toList(),
        ),
        transition: customTrans,
        curve: customCurve,
        duration: duration,
      ),
      child: Padding(
        padding: EdgeInsets.all(width * 0.04),
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
              borderRadius: BorderRadius.all(Radius.circular(width * 0.03))),
          // width: width,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(width * 0.1),
              child: Column(
                children: [
                  const Text(
                    "Avaiable Balance",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Rs. ",
                        style: TextStyle(
                          fontSize: 45.0,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Countup(
                        duration: const Duration(seconds: 1),
                        begin: 0,
                        end: (intakeamount - expense).toDouble(),
                        style: const TextStyle(
                          fontSize: 45.0,
                          color: Colors.green,
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
