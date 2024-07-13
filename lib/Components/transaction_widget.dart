import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Screens/transaction_details.dart';

// Represents a single transaction with details and navigation
class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    super.key,
    required this.name,
    required this.typeOfTransaction,
    required this.amount,
    required this.dateAndTime,
    required this.expenseType,
    required this.transactionReferanceNumber,
    required this.toIncl,
  });

  final String name;
  final String typeOfTransaction;
  final int amount;
  final DateTime dateAndTime;
  final String expenseType;
  final int transactionReferanceNumber;
  final int toIncl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          routeName: "Transaction Details",
          () => TransactionDetails(
            amount: amount,
            dateTime: dateAndTime,
            toName: name,
            transactionReferanceNumber: transactionReferanceNumber,
            expenseType: expenseType,
            transactionType: typeOfTransaction,
            toIncl: toIncl,
          ),
          transition: customTrans,
          curve: customCurve,
          duration: duration,
        );
      },
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(15.w),
              ),
              child: Padding(
                padding: EdgeInsets.all(13.w),
                child: Icon(
                  Icons.shopping_cart,
                  size: 20.r,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 270.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 150.w,
                      child: Text(
                        name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.r),
                      ),
                    ),
                    Row(
                      children: [
                        if (typeOfTransaction == "expense") ...[
                          Text(
                            "Rs. -",
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 18.r,
                                fontWeight: FontWeight.bold),
                          ),
                        ] else ...[
                          Text(
                            "Rs. +",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 18.r,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                        if (typeOfTransaction == "expense") ...[
                          Countup(
                            begin: 0,
                            end: amount.toDouble(),
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 20.r,
                                fontWeight: FontWeight.bold),
                          ),
                        ] else ...[
                          Countup(
                            begin: 0,
                            end: amount.toDouble(),
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 20.r,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      expenseType,
                      style: TextStyle(fontSize: 13.r),
                    ),
                    Text(
                      "${DateFormat.yMMMMd('en_US').format(dateAndTime)}, ${DateFormat.jm().format(dateAndTime)}",
                      style: TextStyle(fontSize: 11.r),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
