import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";
import "package:spendwise/Components/details_button.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Screens/edit_transaction.dart";
import "package:spendwise/Utils/theme.dart";

// TODO: Reduce Lines of Code
class TransactionDetails extends StatefulWidget {
  const TransactionDetails({
    super.key,
    required this.toName,
    required this.amount,
    required this.dateTime,
    required this.transactionReferanceNumber,
    required this.expenseType,
    required this.transactionType,
    required this.toIncl,
  });

  final String? toName;
  final int? amount;
  final DateTime? dateTime;
  final int? transactionReferanceNumber;
  final String? expenseType;
  final String transactionType;
  final int toIncl;

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: SizedBox(
                width: 150.r,
                child: Center(
                  child: Image.asset(
                    "assets/resources/Success2.gif",
                    repeat: ImageRepeat.repeat,
                  ),
                ),
              ),
            ),
            if (widget.transactionType.toString().toLowerCase() ==
                "expense") ...[
              Center(
                child: Text(
                  "Payment Sucessfull",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.r,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 20.w,
                  ),
                  child: Text(
                    "You've paid to ${widget.toName}",
                    style: TextStyle(fontSize: 13.r),
                  ),
                ),
              ),
            ] else ...[
              Center(
                child: Text(
                  "Payment Recieved",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.r,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 30.w,
                  ),
                  child: Text(
                    "You've recived Income, keep saving and Investing.",
                    style: TextStyle(
                      fontSize: 15.r,
                    ),
                  ),
                ),
              ),
            ],
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DetailsButton(
                    btnText: "Share",
                    icon: const Icon(Icons.share),
                    // TODO: -------------------------------------------Add Function defination
                    onTap: () {},
                  ),
                  DetailsButton(
                    btnText: "Print",
                    icon: const Icon(Icons.print),
                    // TODO: -------------------------------------------Add Function defination
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 30.w,
                right: 30.w,
                top: 20.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.expenseType == "income") ...[
                    Text(
                      "From",
                      style: TextStyle(
                        fontSize: 13.r,
                      ),
                    ),
                  ] else ...[
                    Text(
                      "To",
                      style: TextStyle(
                        fontSize: 13.r,
                      ),
                    ),
                  ],
                  Text(
                    widget.toName!,
                    style: TextStyle(
                      fontSize: 13.r,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 30.w,
                right: 30.w,
                top: 15.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Transaction ID",
                    style: TextStyle(fontSize: 13.r),
                  ),
                  Text(
                    widget.transactionReferanceNumber.toString(),
                    style: TextStyle(
                      fontSize: 13.r,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 30.w,
                right: 30.w,
                top: 15.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Date and Time",
                    style: TextStyle(
                      fontSize: 13.r,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        DateFormat.yMMMMd('en_US')
                            .format(widget.dateTime!)
                            .toString(),
                        style: TextStyle(
                          fontSize: 13.r,
                        ),
                      ),
                      Text(
                        ", ",
                        style: TextStyle(
                          fontSize: 13.r,
                        ),
                      ),
                      Text(
                        DateFormat.jm().format(widget.dateTime!).toString(),
                        style: TextStyle(
                          fontSize: 13.r,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 30.w,
                right: 30.w,
                top: 15.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Expense",
                    style: TextStyle(
                      fontSize: 13.r,
                    ),
                  ),
                  Text(
                    "Rs. ${widget.amount}",
                    style: TextStyle(
                      fontSize: 13.r,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 30.w,
                right: 30.w,
                top: 15.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Type",
                    style: TextStyle(
                      fontSize: 13.r,
                    ),
                  ),
                  Text(
                    widget.transactionType,
                    style: TextStyle(
                      fontSize: 13.r,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Divider(
                color: Get.isDarkMode
                    ? MyAppColors.normalColoredWidgetTextColorLightMode
                    : MyAppColors.normalColoredWidgetTextColorDarkMode,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 30.w,
                right: 30.w,
                top: 5.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 13.r,
                    ),
                  ),
                  Text(
                    "Rs. ${widget.amount}",
                    style: TextStyle(
                      fontSize: 13.r,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 30.h,
                bottom: 10.h,
              ),
              child: Container(
                width: 250.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      13.h,
                    ),
                  ),
                  gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.black54,
                      Colors.black87,
                    ],
                  ),
                ),
                child: TextButton(
                  onPressed: () async {
                    dynamic refresh = await Get.to(
                      routeName: "editTransaction",
                      () => EditTransaction(
                        amount: widget.amount!,
                        dateTime: widget.dateTime!,
                        expenseType: widget.expenseType!,
                        toName: widget.toName!,
                        transactionReferanceNumber:
                            widget.transactionReferanceNumber!,
                        transactionType: widget.transactionType,
                        toIncl: widget.toIncl,
                      ),
                      curve: customCurve,
                      transition: customTrans,
                      duration: duration,
                    );

                    if (refresh != null) {
                      Get.back(result: "refresh");
                    }
                  },
                  child: Text(
                    "Edit Transaction",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.r,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Container(
                width: 250.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      13.h,
                    ),
                  ),
                  gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.black54,
                      Colors.black87,
                    ],
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Go Back",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.r,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
