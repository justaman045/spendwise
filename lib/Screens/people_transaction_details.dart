import "dart:io";

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";
import "package:path_provider/path_provider.dart";
import 'package:pdf/widgets.dart' as pw;
import "package:screenshot/screenshot.dart";
import "package:spendwise/Components/details_button.dart";
import "package:spendwise/Models/cus_transaction.dart";
import "package:spendwise/Models/people_expense.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Screens/edit_transaction.dart";
import "package:share_plus/share_plus.dart";
import "package:spendwise/Utils/people_balance_shared_methods.dart";
import "package:spendwise/Utils/theme.dart";
import 'package:path/path.dart';
import "package:spendwise/Utils/transaction_methods.dart";

// TODO: Reduce Lines of Code
class PeopleTransactionDetails extends StatefulWidget {
  const PeopleTransactionDetails({
    super.key,
    required this.transaction,
  });

  final PeopleBalance transaction;

  @override
  State<PeopleTransactionDetails> createState() => _PeopleTransactionDetails();
}

class _PeopleTransactionDetails extends State<PeopleTransactionDetails> {
  CusTransaction? cusTransaction;
  List<PeopleBalance>? peopleBalance;
  final ScreenshotController _screenshotController = ScreenshotController();

  void _getTransaction() async {
    cusTransaction = await TransactionMethods()
        .getTransactionByRef(widget.transaction.transactionReferanceNumber);
    if (cusTransaction != null) {
      setState(() {
        cusTransaction;
      });
    }
  }

  void _getSharedTransaction() async {
    peopleBalance = await PeopleBalanceSharedMethods().getAllPeopleBalanceByRef(
        widget.transaction.transactionReferanceNumber);
    if (peopleBalance != null) {
      setState(() {
        peopleBalance;
      });
    }
  }

  Future<void> _shareScreenshot() async {
    ///Capture and saving to a file
    _screenshotController
        .capture(delay: const Duration(seconds: 1))
        .then((value) async {
      var image = value;

      final dir = await getApplicationDocumentsDirectory();
      final imagePath = await File(
              '${dir.path}/${widget.transaction.transactionFor.replaceAll("/", "")} to ${widget.transaction.name}.png')
          .create();
      await imagePath.writeAsBytes(image!);

      ///Share
      await Share.shareXFiles([XFile(imagePath.path)]);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getSharedTransaction();
    _getTransaction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Screenshot(
          controller: _screenshotController,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30.h),
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
              if (typeOfTransaction[2].toLowerCase() ==
                  cusTransaction?.typeOfTransaction.toLowerCase()) ...[
                Center(
                  child: Text(
                    "Payment Successful",
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
                      "You've paid for ${cusTransaction?.name} on behalf of ${widget.transaction.name}",
                      style: TextStyle(fontSize: 13.r),
                    ),
                  ),
                ),
              ] else ...[
                Center(
                  child: Text(
                    "Payment Successful",
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
                      "${widget.transaction.name} has paid for ${cusTransaction?.name} on behalf of You",
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
                      // TODO: -------------------------------------------Add Function definition
                      onTap: _shareScreenshot,
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
                    Text(
                      "Shared with",
                      style: TextStyle(
                        fontSize: 13.r,
                      ),
                    ),
                    Row(
                      children: peopleBalance!
                          .map(
                            (e) => Text(
                              e.name,
                              style: TextStyle(
                                fontSize: 13.r,
                              ),
                            ),
                          )
                          .toList(),
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
                      widget.transaction.transactionReferanceNumber.toString(),
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
                              .format(cusTransaction!.dateAndTime)
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
                          DateFormat.jm()
                              .format(cusTransaction!.dateAndTime)
                              .toString(),
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
                      cusTransaction!.typeOfTransaction,
                      style: TextStyle(
                        fontSize: 13.r,
                      ),
                    ),
                    Text(
                      "Rs. ${widget.transaction.amount}",
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
                      cusTransaction!.expenseType,
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
                      "Rs. ${widget.transaction.amount}",
                      style: TextStyle(
                        fontSize: 13.r,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40.h,
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
      ),
    );
  }
}
