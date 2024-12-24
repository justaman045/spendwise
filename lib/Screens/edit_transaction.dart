import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";
import "package:spendwise/Models/cus_transaction.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Utils/methods.dart";
import "package:spendwise/Utils/theme.dart";
import "package:spendwise/Utils/transaction_methods.dart";

final _formKey = GlobalKey<FormState>();

// TODO: Reduce Lines of Code
class EditTransaction extends StatefulWidget {
  const EditTransaction({
    super.key, required this.transaction,
  });

  final CusTransaction transaction;

  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  String _expType = "";
  String _toExclude = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController fromDate = TextEditingController();
  TextEditingController amountEditingController = TextEditingController();
  String typeOftransaction = "";

  void updateTransaction(String expenseType) {
    _expType = expenseType;
  }

  void updatetoInclude(String toExclude) {
    _toExclude = toExclude;
  }

  @override
  Widget build(BuildContext context) {
    List<String> typeOfTransaction = typeOfExpense;
    nameController.text = widget.transaction.name;
    fromDate.text = DateFormat.yMMMMd().format(widget.transaction.dateAndTime);
    amountEditingController.text = widget.transaction.amount.toString();
    // TextEditingController expenseEditingController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Transaction"),
        centerTitle: true,
      ),
      body: Form(
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
                height: 48.h,
                child: TextFormField(
                  controller: nameController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Add a Recipient name";
                    } else if (value.length < 3) {
                      return "Name must be at-least 3 characters";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text(
                      "Recipient Name",
                      style: TextStyle(
                        fontSize: 13.r,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.h),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20.r,
                top: 15.h,
                right: 20.w,
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
                left: 20.r,
                top: 15.h,
                right: 20.w,
              ),
              child: TextFormField(
                canRequestFocus: false,
                keyboardType: TextInputType.none,
                controller: fromDate,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_month_rounded),
                    onPressed: () async {
                      dynamic date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(DateTime.now().year - 1),
                          lastDate: DateTime(2099));
                      fromDate.text = DateFormat.yMMMMd().format(date);
                    },
                  ),
                  label: const Text("Start Date of the Subscription"),
                  hintText: "".toString(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
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
                height: 48.h,
                child: TextFormField(
                  controller: amountEditingController,
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true, signed: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\+?\d*'))
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter a amount that have been paid or received";
                    } else if (int.parse(double.parse(value).toInt().toString()) < 1) {
                      return "Amount cannot be in negative";
                    }
                    return null;
                  },
                  readOnly: typeOftransaction.toLowerCase() ==
                          typeOfTransaction[4].toLowerCase()
                      ? true
                      : false,
                  decoration: InputDecoration(
                    label: Text(
                      "Amount",
                      style: TextStyle(
                        fontSize: 13.r,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.h),
                    ),
                  ),
                ),
              ),
            ),
            Column(
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
                      value: widget.transaction.expenseType,
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
                      value: widget.transaction.toInclude == 1 ? "No" : "Yes",
                    ),
                  ),
                ),
              ],
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
                          if (_toExclude != "Yes") {
                            _toExclude = "No";
                          }
                          CusTransaction transaction = CusTransaction(
                            amount: double.parse(amountEditingController.text),
                            dateAndTime: stringToDateTime(fromDate.text),
                            name: nameController.text,
                            typeOfTransaction: widget.transaction.typeOfTransaction,
                            expenseType: _expType.isEmpty
                                ? widget.transaction.expenseType
                                : _expType,
                            transactionReferanceNumber:
                            widget.transaction.transactionReferanceNumber,
                            toInclude: _toExclude == "No" ? 1 : 0,
                          );
                          await TransactionMethods()
                              .updateTransaction(transaction)
                              .then((value) => Get.back(result: "refresh"))
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
                            .deleteTransaction(widget.transaction.transactionReferanceNumber)
                            .then((value) => Get.back(result: "refresh"))
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
      ),
    );
  }
}
