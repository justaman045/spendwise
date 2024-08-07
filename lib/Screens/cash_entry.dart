import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";
import "package:multi_dropdown/multiselect_dropdown.dart";
import "package:spendwise/Models/cus_transaction.dart";
import "package:spendwise/Models/people_expense.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Requirements/transaction.dart";
import "package:spendwise/Utils/people_balance_shared_methods.dart";
import "package:spendwise/Utils/theme.dart";
import "package:spendwise/Utils/transaction_methods.dart";

// TODO: Reduce Lines of Code
final _formKey = GlobalKey<FormState>();

class AddCashEntry extends StatefulWidget {
  const AddCashEntry({super.key});

  @override
  State<AddCashEntry> createState() => _AddCashEntryState();
}

class _AddCashEntryState extends State<AddCashEntry> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController amountEditingController = TextEditingController();
  TextEditingController typeOftransactionEditingController =
      TextEditingController();
  TextEditingController expenseTypeEditingController = TextEditingController();
  TextEditingController endingRecurring = TextEditingController();
  String typeOfexp = "";
  String typeOftransaction = "";
  String transactionReferanceNumber = "";
  DateTime? recurringDate;
  bool isSharable = false;
  MultiSelectController multiSelectDropDownController = MultiSelectController();
  List<PeopleBalance> _peopleBalanceList = [];

  Future<void> _fetchData() async {
    _peopleBalanceList =
        await PeopleBalanceSharedMethods().getAllPeopleBalance();
    setState(() {});
  }

  @override
  void initState() {
    expenseTypeEditingController.text = typeOfExpense[0];
    typeOftransactionEditingController.text = typeOfTransaction[0];
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cash Payment",
          style: TextStyle(fontSize: 20.r),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 30.h,
                  left: 20.w,
                ),
                child: Text(
                  "Payment Details",
                  style: TextStyle(
                    fontSize: 20.r,
                    fontWeight: FontWeight.w500,
                  ),
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
                        child: TextFormField(
                          controller: nameEditingController,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-z A-Z]'))
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Add a Recipient name";
                            } else if (value.length < 4) {
                              return "Name must be atleast 4 charecters";
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
                      child: SizedBox(
                        height: 60.h,
                        child: TextFormField(
                          controller: amountEditingController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true, signed: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\+?\d*'))
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter a amount that have been paid or recived";
                            } else if (int.parse(value) <= 1) {
                              return "Amount cannot be in negetive";
                            }
                            return null;
                          },
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
                              "Type of Expense",
                              style: TextStyle(
                                fontSize: 13.r,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.h),
                            ),
                          ),
                          items: typeOfExpense
                              .map(
                                (e) => DropdownMenuItem(
                                  value: toBeginningOfSentenceCase(e),
                                  child: Text(
                                    toBeginningOfSentenceCase(e),
                                    style: TextStyle(
                                      fontSize: 13.r,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (String? value) => setState(
                            () {
                              if (value != null) typeOfexp = value;
                            },
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
                                  value: toBeginningOfSentenceCase(e),
                                  child: Text(
                                    toBeginningOfSentenceCase(e),
                                    style: TextStyle(
                                      fontSize: 13.r,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (String? value) => setState(
                            () {
                              if (value != null) typeOftransaction = value;
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.r,
                        right: 20.w,
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isSharable,
                            onChanged: (bool? value) {
                              endingRecurring.text = "";
                              setState(
                                () {
                                  isSharable = value!;
                                },
                              );
                            },
                          ),
                          const Text("Share this Expense with Someone?")
                        ],
                      ),
                    ),
                    if (isSharable) ...[
                      Padding(
                        padding:
                            EdgeInsets.only(left: 20.r, top: 15.h, right: 20.w),
                        child: MultiSelectDropDown(
                          backgroundColor:
                              MyAppColors.normalColoredWidgetTextColorDarkMode,
                          showClearIcon: true,
                          controller: multiSelectDropDownController,
                          onOptionSelected: (options) =>
                              debugPrint(options.toString()),
                          options: _peopleBalanceList.isEmpty
                              ? []
                              : _peopleBalanceList
                                  .map((peopleBalance) => ValueItem(
                                        label: peopleBalance.name,
                                        value: peopleBalance.id.toString(),
                                      ))
                                  .toList(),
                          selectionType: SelectionType.multi,
                          chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                          dropdownHeight: 100.h,
                          optionTextStyle: const TextStyle(fontSize: 16),
                          selectedOptionIcon: const Icon(Icons.check_circle),
                        ),
                      )
                    ],
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          debugPrint(typeOftransaction.length.toString());
                          // final user = FirebaseAuth.instance.currentUser;
                          // await FirebaseFirestore.instance
                          //     .collection("Transaction")
                          //     .doc(user!.uid)
                          //     .collection("transactions")
                          //     .doc()
                          //     .set({
                          //   "amount": amountEditingController.text,
                          //   "dateAndTime": DateTime.now(),
                          //   "expenseType": typeOfexp,
                          //   "name": nameEditingController.text,
                          //   "typeOfTransaction": typeOftransaction,
                          //   "transactionReferanceNumber": 0,
                          // }).then((value) => Get.off(
                          //           routeName: "saveAndAdd",
                          //           () => const AddCashEntry(),
                          //           curve: customCurve,
                          //           transition: customTrans,
                          //           duration: duration,
                          //         ));

                          CusTransaction transaction = CusTransaction(
                            amount: double.parse(amountEditingController.text),
                            dateAndTime: DateTime.now(),
                            name: nameEditingController.text,
                            typeOfTransaction: typeOftransaction,
                            expenseType: typeOfexp,
                            transactionReferanceNumber:
                                generateUniqueRefNumber(),
                          );
                          await TransactionMethods()
                              .insertTransaction(transaction)
                              .then(
                                (value) => Get.off(
                                  routeName: "saveAndAdd",
                                  () => const AddCashEntry(),
                                  curve: customCurve,
                                  transition: customTrans,
                                  duration: duration,
                                ),
                              );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11.h),
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
                            "Save and Add another",
                            style: TextStyle(
                              fontSize: 13.r,
                              color: Get.isDarkMode
                                  ? MyAppColors
                                      .normalColoredWidgetTextColorDarkMode
                                  : MyAppColors
                                      .normalColoredWidgetTextColorDarkMode,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        // FirebaseF
                        if (_formKey.currentState!.validate()) {
                          debugPrint(typeOftransaction.length.toString());
                          // final user = FirebaseAuth.instance.currentUser;
                          // await FirebaseFirestore.instance
                          //     .collection("Transaction")
                          //     .doc(user!.uid)
                          //     .collection("transactions")
                          //     .doc()
                          //     .set({
                          //   "amount": amountEditingController.text,
                          //   "dateAndTime": DateTime.now(),
                          //   "expenseType": typeOfexp,
                          //   "name": nameEditingController.text,
                          //   "typeOfTransaction": typeOftransaction,
                          //   "transactionReferanceNumber": 0,
                          // }).then((value) => Get.back());

                          CusTransaction transaction = CusTransaction(
                            amount: double.parse(amountEditingController.text),
                            dateAndTime: DateTime.now(),
                            name: nameEditingController.text,
                            typeOfTransaction: typeOftransaction,
                            expenseType: typeOfexp,
                            transactionReferanceNumber:
                                generateUniqueRefNumber(),
                          );
                          if (isSharable) {
                            for (dynamic valOne in multiSelectDropDownController
                                .selectedOptions) {
                              for (PeopleBalance valTwo in _peopleBalanceList) {
                                if (int.parse(valOne.value) == valTwo.id) {
                                  double updatedAmount;
                                  if (transaction.typeOfTransaction
                                          .toLowerCase() ==
                                      "income") {
                                    updatedAmount =
                                        valTwo.amount - transaction.amount;
                                  } else {
                                    if (multiSelectDropDownController
                                            .selectedOptions.length >
                                        1) {
                                      updatedAmount = valTwo.amount +
                                          (transaction.amount /
                                              (multiSelectDropDownController
                                                      .selectedOptions.length +
                                                  1));
                                    } else {
                                      updatedAmount =
                                          valTwo.amount + transaction.amount;
                                    }
                                  }
                                  if (updatedAmount == 0) {
                                    PeopleBalanceSharedMethods()
                                        .deletePeopleBalance(
                                            valTwo.transactionReferanceNumber);
                                  } else {
                                    PeopleBalanceSharedMethods()
                                        .updatePeopleBalance(
                                      PeopleBalance(
                                        name: valTwo.name,
                                        amount: updatedAmount,
                                        dateAndTime: valTwo.dateAndTime,
                                        transactionFor: valTwo.transactionFor,
                                        relationFrom: valTwo.relationFrom,
                                        transactionReferanceNumber:
                                            valTwo.transactionReferanceNumber,
                                      ),
                                    );
                                  }
                                }
                              }
                            }
                          }
                          //TODO: Maybe reciving portion is done sending portion is remaining
                          if (transaction.typeOfTransaction.toLowerCase() !=
                              typeOfTransaction[2].toLowerCase()) {
                            await TransactionMethods()
                                .insertTransaction(transaction)
                                .then(
                                  (value) => Get.back(result: "refresh"),
                                );
                          } else {
                            Get.back(result: "refresh");
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11.w),
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
                            "Add Payment",
                            style: TextStyle(
                              fontSize: 13.r,
                              color: Get.isDarkMode
                                  ? MyAppColors
                                      .normalColoredWidgetTextColorDarkMode
                                  : MyAppColors
                                      .normalColoredWidgetTextColorDarkMode,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.h, bottom: 25.h),
                child: Center(
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.w),
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
                            color: Get.isDarkMode
                                ? MyAppColors
                                    .normalColoredWidgetTextColorDarkMode
                                : MyAppColors
                                    .normalColoredWidgetTextColorDarkMode,
                          ),
                        ),
                      ),
                    ),
                    onTap: () => Get.back(),
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
