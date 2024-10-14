import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";
import "package:spendwise/Models/cus_transaction.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Utils/theme.dart";
import "package:spendwise/Utils/transaction_methods.dart";

final _formKey = GlobalKey<FormState>();

// TODO: Reduce Lines of Code
class EditTransaction extends StatefulWidget {
  const EditTransaction({
    super.key,
    required this.toName,
    required this.amount,
    required this.dateTime,
    required this.transactionReferanceNumber,
    required this.expenseType,
    required this.transactionType,
    required this.toIncl,
  });

  final String toName;
  final int amount;
  final DateTime dateTime;
  final int transactionReferanceNumber;
  final String expenseType;
  final String transactionType;
  final int toIncl;

  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  String _expType = "";
  String _toExclude = "";

  void updateTransaction(String expenseType) {
    _expType = expenseType;
  }

  void updatetoInclude(String toExclude) {
    _toExclude = toExclude;
  }

  @override
  Widget build(BuildContext context) {
    List<String> typeOfTransaction = typeOfExpense;
    // TextEditingController expenseEditingController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Transaction"),
        centerTitle: true,
      ),
      body: Column(
        children: [
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
                  widget.toName,
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
                          .format(widget.dateTime)
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
                      DateFormat.jm().format(widget.dateTime).toString(),
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
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.r,
                    top: 15.h,
                    right: 20.w,
                  ),
                  child: SizedBox(
                    height: 60.h,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        label: Text(
                          "Income/Expense",
                          style: TextStyle(
                            fontSize: 13.r,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.h),
                        ),
                      ),
                      items: typeOfTransaction
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: TextStyle(
                                  fontSize: 13.r,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) {
                        if (value != null) {
                          // Call updateTransaction with the selected value
                          updateTransaction(value);
                        }
                      },
                      value: widget.expenseType,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.r,
                    top: 15.h,
                    right: 20.w,
                  ),
                  child: SizedBox(
                    height: 60.h,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        label: Text(
                          "Exclude this Transaction",
                          style: TextStyle(
                            fontSize: 13.r,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.h),
                        ),
                      ),
                      items: ["Yes", "No"]
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: TextStyle(
                                  fontSize: 13.r,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) {
                        if (value != null) {
                          // Call updateTransaction with the selected value
                          updatetoInclude(value);
                        }
                      },
                      value: widget.toIncl == 1 ? "No" : "Yes",
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 50.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromRGBO(210, 209, 254, 1),
                              Color.fromRGBO(243, 203, 237, 1),
                            ],
                          ),
                        ),
                        width: 100.w,
                        height: 50.h,
                        child: Center(
                          child: Text(
                            "Go Back",
                            style: TextStyle(
                              fontSize: 13.r,
                              color: Get.isDarkMode
                                  ? MyAppColors
                                      .normalColoredWidgetTextColorDarkMode
                                  : MyAppColors
                                      .normalColoredWidgetTextColorLightMode,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          debugPrint(_expType.toString());
                        }
                        if (_expType.isNotEmpty || _toExclude.isNotEmpty) {
                          if (_toExclude != "Yes") {
                            _toExclude = "No";
                          }
                          CusTransaction transaction = CusTransaction(
                            amount: widget.amount.toDouble(),
                            dateAndTime: widget.dateTime,
                            name: widget.toName,
                            typeOfTransaction: widget.transactionType,
                            expenseType: _expType.isEmpty
                                ? widget.expenseType
                                : _expType,
                            transactionReferanceNumber:
                                widget.transactionReferanceNumber,
                            toInclude: _toExclude == "No" ? 1 : 0,
                          );
                          await TransactionMethods()
                              .updateTransaction(transaction)
                              .then((value) => Get.back())
                              .then((value) => Get.back(result: "refresh"));
                        } else {
                          Get.snackbar(
                            "Error",
                            "This Feature is still under Development",
                            snackPosition: SnackPosition.TOP,
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromRGBO(210, 209, 254, 1),
                              Color.fromRGBO(243, 203, 237, 1),
                            ],
                          ),
                        ),
                        width: 100.w,
                        height: 50.h,
                        child: Center(
                          child: Text(
                            "Save Changes",
                            style: TextStyle(
                              fontSize: 13.r,
                              color: Get.isDarkMode
                                  ? MyAppColors
                                      .normalColoredWidgetTextColorDarkMode
                                  : MyAppColors
                                      .normalColoredWidgetTextColorLightMode,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: GestureDetector(
                    onTap: () async {
                      await TransactionMethods()
                          .deleteTransaction(widget.transactionReferanceNumber)
                          .then((value) => Get.back(result: "refresh"));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromRGBO(210, 209, 254, 1),
                            Color.fromRGBO(243, 203, 237, 1),
                          ],
                        ),
                      ),
                      width: 150.w,
                      height: 50.h,
                      child: Center(
                        child: Text(
                          "Delete Transaction",
                          style: TextStyle(
                            fontSize: 13.r,
                            color: Get.isDarkMode
                                ? MyAppColors
                                    .normalColoredWidgetTextColorDarkMode
                                : MyAppColors
                                    .normalColoredWidgetTextColorLightMode,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
