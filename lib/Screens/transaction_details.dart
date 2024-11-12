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
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Screens/edit_transaction.dart";
import "package:share_plus/share_plus.dart";
import "package:spendwise/Utils/theme.dart";
import 'package:path/path.dart';

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
  final ScreenshotController _screenshotController = ScreenshotController();

  Future<void> _shareScreenshot() async {

    ///Capture and saving to a file
    _screenshotController.capture(delay: const Duration(seconds: 1)).then((value) async {
      var image = value;

      final dir = await getApplicationDocumentsDirectory();
      final imagePath = await File('${dir.path}/${widget.transactionType} to ${widget.toName}.png').create();
      await imagePath.writeAsBytes(image!);


      ///Share
      await Share.shareXFiles([XFile(imagePath.path)]);

    });


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
              if (widget.transactionType.toString().toLowerCase() !=
                  typeOfTransaction[0].toLowerCase()) ...[
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
                      "You've paid to ${widget.toName}",
                      style: TextStyle(fontSize: 13.r),
                    ),
                  ),
                ),
              ] else ...[
                Center(
                  child: Text(
                    "Payment Received",
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
                      "You've received Income, keep saving and Investing.",
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
                      onTap: () {
_shareScreenshot();
                      },
                    ),
                    DetailsButton(
                      btnText: "Print",
                      icon: const Icon(Icons.print),
                      // TODO: -------------------------------------------Add Function definition
                      onTap: generatePDF,
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
                    if (widget.expenseType == typeOfExpense[0]) ...[
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
                      widget.transactionType,
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
      ),
    );
  }

  void generatePDF() async {
                    final pdf = pw.Document();

                    pdf.addPage(
                      pw.Page(
                        build: (pw.Context context) {
                          return pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                height: 40.h,
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.symmetric(vertical: 5.h),
                                child: pw.Text(
                                  appName,
                                  style: pw.TextStyle(fontSize: 30.r),
                                ),
                              ),
                              pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.end,
                                children: [
                                  pw.Padding(
                                    padding: pw.EdgeInsets.symmetric(vertical: 5.h),
                                    child: pw.SizedBox(
                                      width: 210.w,
                                      child: pw.Text(
                                        "This Receipt is Generated via App by ${FirebaseAuth.instance.currentUser!.email}",
                                        textAlign: pw.TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                children: [
                                  pw.Column(
                                    children: [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(vertical: 15.h),
                                        child: pw.Text(
                                          "Transaction Receipt",
                                          style: pw.TextStyle(fontSize: 25.r),
                                        ),
                                      ),
                                      pw.SizedBox(
                                        width: 230.w,
                                        child: pw.Text(
                                          "Generated by $appName for ${Platform.isAndroid ? "Android" : Platform.isIOS ? "iPhone" : Platform.isWindows ? "Windows" : Platform.isMacOS ? "macOS" : "Linux"}  on ${DateFormat.yMMMMd().format(DateTime.now())}",
                                          textAlign: pw.TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.symmetric(vertical: 30.h),
                                child: pw.Column(
                                  children: [
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(horizontal: 45.w),
                                      child: pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text("Transaction Amount"),
                                          pw.Text(widget.amount.toString())
                                        ],
                                      ),
                                    ),
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(horizontal: 40.w),
                                      child: pw.Divider(),
                                    ),
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(horizontal: 45.w),
                                      child: pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text("Transaction Type"),
                                          pw.Text(widget.transactionType.toString())
                                        ],
                                      ),
                                    ),
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(horizontal: 40.w),
                                      child: pw.Divider(),
                                    ),
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(horizontal: 45.w),
                                      child: pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text("Transaction Date"),
                                          pw.Text(widget.dateTime.toString())
                                        ],
                                      ),
                                    ),
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(horizontal: 40.w),
                                      child: pw.Divider(),
                                    ),
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(horizontal: 45.w),
                                      child: pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                        children: [pw.Text("Sender"), pw.Text(Platform.operatingSystemVersion)],
                                      ),
                                    ),
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(horizontal: 40.w),
                                      child: pw.Divider(),
                                    ),
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(horizontal: 45.w),
                                      child: pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                        children: [pw.Text("Beneficiary"), pw.Text(widget.toName.toString())],
                                      ),
                                    ),
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(horizontal: 40.w),
                                      child: pw.Divider(),
                                    ),
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(horizontal: 45.w),
                                      child: pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                        //TODO: To add a remark option in future
                                        children: [pw.Text("Remark"), pw.Text("")],
                                      ),
                                    ),
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(horizontal: 40.w),
                                      child: pw.Divider(),
                                    ),
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(horizontal: 45.w),
                                      child: pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text("Transaction Reference"),
                                          pw.Text(widget.transactionReferanceNumber.toString())
                                        ],
                                      ),
                                    ),
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(horizontal: 40.w),
                                      child: pw.Divider(),
                                    ),
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(horizontal: 45.w),
                                      child: pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text("Transaction Status"),
                                          pw.Text("Successful")
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              pw.Spacer(),
                              pw.Divider(),
                              pw.Padding(
                                padding: pw.EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
                                child: pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.SizedBox(
                                      width: 150.w,
                                      child: pw.Column(
                                        children: [
                                          pw.Text("Repo URL:- github.com/justaman045/spendiwse")
                                        ],
                                      ),
                                    ),
                                    pw.Text(
                                      appName,
                                      style: pw.TextStyle(fontSize: 25.r),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );

                    final file = File(join("/storage/emulated/0/Download",'${widget.expenseType} to ${widget.toName}.pdf'));
                    await file.writeAsBytes(await pdf.save());
                  }
}
