import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Screens/transaction_details.dart';

// TODO: Reduce Lines of Code
class TransactionWidget extends StatefulWidget {
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
    required this.toIncl,
  });

  final double width;
  final double height;
  final String name;
  final String typeOfTransaction;
  final int amount;
  final DateTime dateAndTime;
  final String expenseType;
  final int transactionReferanceNumber;
  final int toIncl;

  @override
  State<TransactionWidget> createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<TransactionWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final refresh = Get.to(
          routeName: "Transaction Details",
          () => TransactionDetails(
            amount: widget.amount,
            dateTime: widget.dateAndTime,
            toName: widget.name,
            transactionReferanceNumber: widget.transactionReferanceNumber,
            expenseType: widget.expenseType,
            transactionType: widget.typeOfTransaction,
            toIncl: widget.toIncl,
          ),
          transition: customTrans,
          curve: customCurve,
          duration: duration,
        );

        if (refresh != null) {
          setState(() {});
        }
      },
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 15.h,
            ),
            // padding: EdgeInsets.symmetric(
            //     horizontal: width * 0.04, vertical: height * 0.01),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(
                  Radius.circular(15.w),
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(13.w),
                    child: Icon(
                      Icons.shopping_cart,
                      size: 20.r,
                    ),
                  ),
                ],
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
                        widget.name.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.r,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        if (widget.typeOfTransaction == "expense") ...[
                          Text(
                            "Rs. -",
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 18.r,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ] else ...[
                          Text(
                            "Rs. +",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 18.r,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                        if (widget.typeOfTransaction == "expense") ...[
                          Countup(
                            begin: 0,
                            end: widget.amount.toDouble(),
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 20.r,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ] else ...[
                          Countup(
                            begin: 0,
                            end: widget.amount.toDouble(),
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 20.r,
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
                    Text(
                      widget.expenseType,
                      style: TextStyle(
                        fontSize: 13.r,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          DateFormat.yMMMMd('en_US')
                              .format(widget.dateAndTime)
                              .toString(),
                          style: TextStyle(fontSize: 11.r),
                        ),
                        Text(", ",
                            style: TextStyle(
                              fontSize: 11.r,
                            )),
                        Text(
                          DateFormat.jm().format(widget.dateAndTime).toString(),
                          style: TextStyle(
                            fontSize: 11.r,
                          ),
                        )
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
