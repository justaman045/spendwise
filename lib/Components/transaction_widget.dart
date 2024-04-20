import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Screens/transaction_details.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    super.key,
    required this.width,
    required this.name,
    required this.typeOfTransaction,
    required this.amount,
    required this.dateAndTime,
    required this.height,
    required this.expenseType,
    required this.transactionReferanceNumber,
  });

  final double width;
  final double height;
  final String name;
  final String typeOfTransaction;
  final int amount;
  final DateTime dateAndTime;
  final String expenseType;
  final int transactionReferanceNumber;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
        routeName: "Transaction Details",
        () => TransactionDetails(
          amount: amount,
          dateTime: dateAndTime,
          toName: name,
          transactionReferanceNumber: transactionReferanceNumber,
          expenseType: expenseType,
        ),
        transition: customTrans,
        curve: customCurve,
        duration: duration,
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: height * 0.015,
            ),
            // padding: EdgeInsets.symmetric(
            //     horizontal: width * 0.04, vertical: height * 0.01),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(
                  Radius.circular(width * 0.04),
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(width * 0.04),
                    child: const Icon(
                      Icons.shopping_cart,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    Row(
                      children: [
                        if (expenseType == "expense") ...[
                          const Text(
                            "Rs. -",
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ] else ...[
                          const Text(
                            "Rs. +",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                        if (expenseType == "expense") ...[
                          Countup(
                            begin: 0,
                            end: amount.toDouble(),
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ] else ...[
                          Countup(
                            begin: 0,
                            end: amount.toDouble(),
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(typeOfTransaction),
                    Row(
                      children: [
                        Text(
                          DateFormat.yMMMMd('en_US')
                              .format(dateAndTime)
                              .toString(),
                        ),
                        const Text(", "),
                        Text(DateFormat.jm().format(dateAndTime).toString())
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
