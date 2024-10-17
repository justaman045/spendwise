import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";
import "package:multi_dropdown/multi_dropdown.dart";
import "package:spendwise/Models/cus_transaction.dart";
import "package:spendwise/Models/people_expense.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Requirements/transaction.dart";
import "package:spendwise/Screens/add_people.dart";
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
  bool isSharable = true;
  bool toAddNewPerson = false;
  bool toIncludeYourself = false;
  MultiSelectController<String> multiSelectDropDownController =
      MultiSelectController<String>();
  List<PeopleBalance> _peopleBalanceList = [];
  List<PeopleBalance> people = [];
  Future? _future;
  double updatedAmount = 0;
  late CusTransaction transaction;


  Future<void> _fetchData() async {
    _peopleBalanceList =
        await PeopleBalanceSharedMethods().getAllPeopleBalance();
    setState(() {});
  }

  Future<void> _refreshData() async {
    setState(() {
      _peopleBalanceList.clear();
      _future = PeopleBalanceSharedMethods().getAllPeopleBalance();
    });
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
                              if (value != null) {
                                typeOftransaction = value;
                                typeOftransactionEditingController.text =
                                    typeOftransaction;
                              }
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ),
                    if (((typeOftransactionEditingController.text)
                                .toLowerCase() !=
                            (typeOfTransaction[0]).toLowerCase()) &&
                        ((typeOftransactionEditingController.text)
                                .toLowerCase() !=
                            (typeOfTransaction[1]).toLowerCase())) ...[
                      Padding(
                        padding: EdgeInsets.only(
                          left: 30.r,
                          right: 20.w,
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              value: toAddNewPerson,
                              onChanged: (bool? value) {
                                endingRecurring.text = "";
                                setState(
                                  () {
                                    toAddNewPerson = value!;
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              width: 250.w,
                              child: const Text(
                                  "If the person is not available in the list, Click here"),
                            )
                          ],
                        ),
                      ),
                      if (toAddNewPerson == false) ...[
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.r,
                            top: 15.h,
                            right: 20.w,
                          ),
                          child: MultiDropdown<String>(
                            controller: multiSelectDropDownController,
                            onSelectionChange: (options) =>
                                {debugPrint(options.toString())},
                            items: _peopleBalanceList.isEmpty
                                ? []
                                : _peopleBalanceList
                                    .map((peopleBalance) => DropdownItem(
                                          label: peopleBalance.name,
                                          value: peopleBalance.id.toString(),
                                        ))
                                    .toList(),
                            dropdownItemDecoration:
                                const DropdownItemDecoration(
                              backgroundColor: Color.fromRGBO(0, 0, 0, 1),
                            ),
                            chipDecoration: const ChipDecoration(
                              wrap: true,
                              backgroundColor: Color.fromRGBO(0, 0, 0, 1),
                            ),
                            validator: (selectedOptions) {
                              if (selectedOptions!.isEmpty) {
                                return "Select any Person to share the Expense/Income";
                              }

                              return null;
                            },
                          ),
                        ),
                      ] else ...[
                        GestureDetector(
                          onTap: () async {
                            final toreload = await Get.to(
                              routeName: "add_people",
                              () => const AddPeople(),
                              curve: customCurve,
                              transition: customTrans,
                              duration: duration,
                            );

                            if (toreload != null) {
                              _refreshData();
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.r),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: colorsOfGradient(),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.r,
                                  vertical: 10.r,
                                ),
                                child: const Text("Add a New Person"),
                              ),
                            ),
                          ),
                        ),
                      ]
                    ],
                    Padding(
                      padding: EdgeInsets.only(
                        left: 30.r,
                        right: 20.w,
                        top: 10.h,
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: toIncludeYourself,
                            onChanged: (bool? value) {
                              endingRecurring.text = "";
                              setState(
                                () {
                                  toIncludeYourself = value!;
                                },
                              );
                            },
                          ),
                          SizedBox(
                            width: 250.w,
                            child: const Text(
                                "Click here to divide the amount between only the selected Persons"),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // --------------------------------------------------------------
              Padding(
                padding: EdgeInsets.only(top: 25.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
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
                        if (_formKey.currentState!.validate()) {
                          if (typeOftransactionEditingController.text
                                  .toLowerCase() ==
                              typeOfTransaction[2].toLowerCase()) {
                            if (multiSelectDropDownController
                                .selectedItems.length
                                .isGreaterThan(0)) {
                              for (PeopleBalance peopleBalance
                                  in _peopleBalanceList) {
                                for (DropdownItem name
                                    in multiSelectDropDownController
                                        .selectedItems) {
                                  if (name.label == peopleBalance.name) {
                                    double newAmount = peopleBalance.amount;
                                    newAmount += (double.parse(
                                            amountEditingController.text) /
                                        (multiSelectDropDownController
                                                .selectedItems.length +
                                            (toIncludeYourself ? 0 : 1)));
                                    PeopleBalanceSharedMethods()
                                        .updatePeopleBalance(PeopleBalance(
                                            name: peopleBalance.name,
                                            amount: newAmount,
                                            dateAndTime:
                                                peopleBalance.dateAndTime,
                                            transactionFor:
                                                peopleBalance.transactionFor,
                                            relationFrom:
                                                peopleBalance.relationFrom,
                                            transactionReferanceNumber:
                                                peopleBalance
                                                    .transactionReferanceNumber));
                                    transaction = CusTransaction(
                                      amount: double.parse(amountEditingController.text),
                                      dateAndTime: DateTime.now(),
                                      name: nameEditingController.text,
                                      typeOfTransaction:
                                          typeOftransactionEditingController
                                              .text,
                                      expenseType: typeOfexp,
                                      transactionReferanceNumber:
                                          generateUniqueRefNumber(),
                                    );
                                  }
                                }
                              }
                            }
                          } else if (typeOftransactionEditingController.text
                                  .toLowerCase() ==
                              typeOfTransaction[3].toLowerCase()) {
                            if (multiSelectDropDownController
                                .selectedItems.length
                                .isGreaterThan(0)) {
                              for (PeopleBalance peopleBalance
                                  in _peopleBalanceList) {
                                for (DropdownItem name
                                    in multiSelectDropDownController
                                        .selectedItems) {
                                  if (name.label == peopleBalance.name) {
                                    double newAmount = peopleBalance.amount;
                                    newAmount -= (double.parse(
                                            amountEditingController.text) /
                                        (multiSelectDropDownController
                                                .selectedItems.length +
                                            (toIncludeYourself ? 0 : 1)));
                                    PeopleBalanceSharedMethods()
                                        .updatePeopleBalance(PeopleBalance(
                                            name: peopleBalance.name,
                                            amount: newAmount,
                                            dateAndTime:
                                                peopleBalance.dateAndTime,
                                            transactionFor:
                                                peopleBalance.transactionFor,
                                            relationFrom:
                                                peopleBalance.relationFrom,
                                            transactionReferanceNumber:
                                                peopleBalance
                                                    .transactionReferanceNumber));
                                    transaction = CusTransaction(
                                      amount: double.parse(amountEditingController.text),
                                      dateAndTime: DateTime.now(),
                                      name: nameEditingController.text,
                                      typeOfTransaction:
                                          typeOftransactionEditingController
                                              .text,
                                      expenseType: typeOfexp,
                                      transactionReferanceNumber:
                                          generateUniqueRefNumber(),
                                    );
                                  }
                                }
                              }
                            }
                          } else {
                            transaction = CusTransaction(
                              amount: double.parse(
                                  amountEditingController.text),
                              dateAndTime: DateTime.now(),
                              name: nameEditingController.text,
                              typeOfTransaction:
                              typeOftransactionEditingController.text,
                              expenseType: typeOfexp,
                              transactionReferanceNumber:
                              generateUniqueRefNumber(),
                            );
                          }

                          await TransactionMethods()
                              .insertTransaction(transaction)
                              .then(
                                (value) => Get.back(result: "refresh"),
                              );
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
              // --------------------------------------------------------------
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
