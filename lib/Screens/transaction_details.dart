import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";
import "package:spendwise/Components/responsive_methods.dart";

class TransactionDetails extends StatelessWidget {
  const TransactionDetails({
    super.key,
    required this.toName,
    required this.amount,
    required this.dateTime,
    required this.transactionReferanceNumber,
    required this.expenseType,
  });

  final String toName;
  final int amount;
  final DateTime dateTime;
  final int transactionReferanceNumber;
  final String expenseType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 90.h),
              child: SizedBox(
                width: 150.r,
                child: const Center(
                  child: Image(
                    image: AssetImage("assets/resources/success.gif"),
                  ),
                ),
              ),
            ),
            if (expenseType == "expense") ...[
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
                    "You've paid to $toName",
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
                    width: getScreenWidth(context),
                    btnText: "Share",
                    icon: const Icon(Icons.share),
                  ),
                  DetailsButton(
                    width: getScreenWidth(context),
                    btnText: "Print",
                    icon: const Icon(Icons.print),
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
                  if (expenseType == "income") ...[
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
                    toName,
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
                    transactionReferanceNumber.toString(),
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
                        DateFormat.yMMMMd('en_US').format(dateTime).toString(),
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
                        DateFormat.jm().format(dateTime).toString(),
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
                    "Rs. $amount",
                    style: TextStyle(
                      fontSize: 13.r,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 35.h),
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

class DetailsButton extends StatelessWidget {
  const DetailsButton({
    super.key,
    required this.width,
    required this.btnText,
    required this.icon,
  });

  final double width;
  final String btnText;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width * 0.04),
        border: Border.all(
          width: 1.w,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Row(
          children: [
            icon,
            SizedBox(
              width: 7.w,
            ),
            Text(
              btnText,
              style: TextStyle(fontSize: 15.r),
            ),
          ],
        ),
      ),
    );
  }
}
