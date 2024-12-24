import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/Models/cus_transaction.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Requirements/transaction.dart';
import 'package:spendwise/Screens/transaction_details.dart';

// Represents a single transaction with details and navigation
class TransactionWidget extends StatefulWidget {
  const TransactionWidget({
    super.key,
    required this.refreshData, required this.transaction,
  });

  final CusTransaction transaction;
  final Function refreshData;

  @override
  State<TransactionWidget> createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<TransactionWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        dynamic refresh = await Get.to(
          routeName: "Transaction Details",
          () => TransactionDetails(transaction: widget.transaction,
          ),
          transition: customTrans,
          curve: customCurve,
          duration: duration,
        );

        if (refresh != null) {
          setState(() {
            widget.refreshData();
          });
        }
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
                  getIconData(widget.transaction.expenseType),
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
                        widget.transaction.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.r),
                      ),
                    ),
                    Row(
                      children: [
                        if (widget.transaction.typeOfTransaction.toLowerCase() !=
                            typeOfTransaction[0]) ...[
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
                        if (widget.transaction.typeOfTransaction.toLowerCase() !=
                            typeOfTransaction[0]) ...[
                          Countup(
                            begin: 0,
                            duration: duration,
                            end: widget.transaction.amount.toDouble(),
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 20.r,
                                fontWeight: FontWeight.bold),
                          ),
                        ] else ...[
                          Countup(
                            begin: 0,
                            duration: duration,
                            end: widget.transaction.amount.toDouble(),
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
                      widget.transaction.expenseType,
                      style: TextStyle(fontSize: 13.r),
                    ),
                    SizedBox(
                      width: 120.w,
                      child: Text(
                        "${DateFormat.yMMMMd('en_US').format(widget.transaction.dateAndTime)}, ${DateFormat.jm().format(widget.transaction.dateAndTime)}",
                        style: TextStyle(fontSize: 11.r),
                        textAlign: TextAlign.right,
                      ),
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
