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
import "package:spendwise/Utils/methods.dart";
import "package:spendwise/Utils/people_balance_shared_methods.dart";
import "package:spendwise/Utils/theme.dart";
import "package:spendwise/Utils/transaction_methods.dart";
import "package:spendwise/Utils/utils.dart";

// TODO: Reduce Lines of Code
final _formKey = GlobalKey<FormState>();

class AddCashEntry extends StatefulWidget {
  const AddCashEntry({super.key});

  static const route = '/cashentry';

  @override
  State<AddCashEntry> createState() => _AddCashEntryState();
}

class _AddCashEntryState extends State<AddCashEntry> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController amountEditingController = TextEditingController();
  TextEditingController fromDate = TextEditingController();
  TextEditingController typeOftransactionEditingController =
      TextEditingController();
  String save = "";
  TextEditingController expenseTypeEditingController = TextEditingController();
  TextEditingController endingRecurring = TextEditingController();
  String typeOfexp = "";
  String typeOftransaction = "";
  String transactionReferanceNumber = "";
  DateTime? recurringDate;
  bool isSharable = true;
  bool toAddNewPerson = false;
  bool toIncludeYourself = false;
  bool pastDateTransaction = false;
  MultiSelectController<String> multiSelectDropDownController =
      MultiSelectController<String>();
  List<PeopleBalance> _peopleBalanceList = [];
  List<PeopleBalance> people = [];
  double updatedAmount = 0;
  late CusTransaction transaction;
  DateTime? fromdate;

  Future<void> _fetchData() async {
    _peopleBalanceList =
        await PeopleBalanceSharedMethods().getAllPeopleBalance();
    setState(() {});
  }

  Future<void> _refreshData() async {
    setState(() {
      _peopleBalanceList.clear();
      PeopleBalanceSharedMethods().getAllPeopleBalance();
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
                    TextBox(
                      controller: nameEditingController,
                      formatter: formatters["Name"]!,
                      labelString: "Recipient Name",
                      function: validators["Name"]!,
                    ),
                    TextBox(
                      controller: amountEditingController,
                      formatter: formatters["Amount"]!,
                      labelString: "Amount",
                      function: validators["Amount"]!,
                      readOnly: typeOftransaction.toLowerCase() ==
                              typeOfTransaction[4].toLowerCase()
                          ? true
                          : false,
                    ),
                    OptionBox(
                      function: (newValue) => setState(() {
                        typeOfexp = newValue!;
                      }),
                      items: getDropDownMenuItems(typeOfExpense),
                      labelString: "Type Of Expense",
                    ),
                    OptionBox(
                      function: (String? value) => setState(
                            () {
                          if (value != null) {
                            typeOftransaction = value;
                            typeOftransactionEditingController.text =
                                typeOftransaction;
                          }
                          if (multiSelectDropDownController
                              .selectedItems.isNotEmpty) {
                            if (typeOftransactionEditingController.text
                                .toLowerCase() ==
                                typeOfTransaction[4].toLowerCase()) {
                              for (PeopleBalance people
                              in _peopleBalanceList) {
                                if (multiSelectDropDownController
                                    .selectedItems[0].label
                                    .toLowerCase() ==
                                    people.name.toLowerCase()) {
                                  save = amountEditingController.text;
                                  debugPrint(
                                      (people.amount * -1).toString());
                                  amountEditingController.text =
                                      ((people.amount) * -1).toString();
                                }
                              }
                            } else if ((typeOftransactionEditingController
                                .text
                                .toLowerCase() !=
                                typeOfTransaction[4].toLowerCase()) &&
                                save != "") {
                              amountEditingController.text = save;
                            }
                          }
                          setState(() {});
                        },
                      ),
                      items: getDropDownMenuItems(typeOfTransaction),
                      labelString: "InDev Income/Expense",
                    ),
                    if (pastDateTransaction == true) ...[
                      DateField(dateController: fromDate),
                    ],
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
                            maxSelections: typeOftransaction.toLowerCase() ==
                                    typeOfTransaction[4].toLowerCase()
                                ? 1
                                : 500,
                            controller: multiSelectDropDownController,
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
                            onSelectionChange: (List<String> list) {
                              if (typeOftransactionEditingController.text
                                      .toLowerCase() ==
                                  typeOfTransaction[4].toLowerCase()) {
                                for (PeopleBalance people
                                    in _peopleBalanceList) {
                                  if (multiSelectDropDownController
                                          .selectedItems[0].label
                                          .toLowerCase() ==
                                      people.name.toLowerCase()) {
                                    save = amountEditingController.text;
                                    amountEditingController.text =
                                        (((people.amount) * -1).toInt())
                                            .toString();
                                  }
                                }
                              } else if ((typeOftransactionEditingController
                                          .text
                                          .toLowerCase() !=
                                      typeOfTransaction[4].toLowerCase()) &&
                                  save != "") {
                                amountEditingController.text = save;
                              }
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
                    if (true) ...[
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
                    Padding(
                      padding: EdgeInsets.only(
                        left: 30.r,
                        right: 20.w,
                        top: 10.h,
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: pastDateTransaction,
                            onChanged: (bool? value) {
                              setState(
                                () {
                                  pastDateTransaction = value!;
                                },
                              );
                            },
                          ),
                          SizedBox(
                            width: 250.w,
                            child: const Text(
                                "Click here to add a Date Of the Transaction"),
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
                            dateAndTime: pastDateTransaction == true
                                ? stringToDateTime(fromDate.text)
                                : DateTime.now(),
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
                                      amount: double.parse(
                                          amountEditingController.text),
                                      dateAndTime: pastDateTransaction == true
                                          ? stringToDateTime(fromDate.text)
                                          : DateTime.now(),
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
                                      amount: double.parse(
                                          amountEditingController.text),
                                      dateAndTime: pastDateTransaction == true
                                          ? stringToDateTime(fromDate.text)
                                          : DateTime.now(),
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
                              typeOfTransaction[4].toLowerCase()) {
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
                                    if (peopleBalance.amount.toInt() > 0) {
                                      newAmount -= (double.parse(
                                              amountEditingController.text) /
                                          (multiSelectDropDownController
                                                  .selectedItems.length +
                                              (toIncludeYourself ? 0 : 1)));
                                    } else {
                                      newAmount += (double.parse(
                                              amountEditingController.text) /
                                          (multiSelectDropDownController
                                                  .selectedItems.length +
                                              (toIncludeYourself ? 0 : 1)));
                                    }
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
                                      amount: double.parse(
                                          amountEditingController.text),
                                      dateAndTime: pastDateTransaction == true
                                          ? stringToDateTime(fromDate.text)
                                          : DateTime.now(),
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
                              amount:
                                  double.parse(amountEditingController.text),
                              dateAndTime: pastDateTransaction == true
                                  ? stringToDateTime(fromDate.text)
                                  : DateTime.now(),
                              name: nameEditingController.text,
                              typeOfTransaction:
                                  typeOftransactionEditingController.text,
                              expenseType: typeOfexp,
                              transactionReferanceNumber:
                                  generateUniqueRefNumber(),
                            );
                          }

                          if (transaction.typeOfTransaction
                                  .toString()
                                  .toLowerCase() !=
                              typeOfTransaction[3].toString().toLowerCase()) {
                            await TransactionMethods()
                                .insertTransaction(transaction)
                                .then(
                                  (value) => Get.back(result: "refresh"),
                                );
                          } else {
                            Get.back(result: "result");
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

class OptionBox extends StatelessWidget {
  const OptionBox({
    super.key,
    required this.function,
    required this.labelString,
    required this.items,
  });

  final Function function;
  final String labelString;
  final List<DropdownMenuItem<String>> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.r,
        top: 15.h,
        right: 20.w,
      ),
      child: SizedBox(
        height: 48.h,
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            label: Text(
              labelString,
              style: TextStyle(
                fontSize: 13.r,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.h),
            ),
          ),
          items: items,
          onChanged: (String? value) => function(value),
        ),
      ),
    );
  }
}

class TextBox extends StatelessWidget {
  const TextBox({
    super.key,
    required this.controller,
    required this.formatter,
    required this.function,
    required this.labelString,
    this.readOnly = false,
  });

  final TextEditingController controller;
  final List<FilteringTextInputFormatter> formatter;
  final Function function;
  final String labelString;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.r,
        top: 15.h,
        right: 20.w,
      ),
      child: SizedBox(
        height: 50.h,
        child: TextFormField(
          controller: controller,
          inputFormatters: formatter,
          validator: (value) => function(value),
          decoration: InputDecoration(
            label: Text(
              labelString,
              style: TextStyle(
                fontSize: 13.r,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.h),
            ),
          ),
          readOnly: readOnly,
        ),
      ),
    );
  }
}

class DateField extends StatelessWidget {
  const DateField({super.key, required this.dateController});

  final TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.r,
        top: 15.h,
        right: 20.w,
      ),
      child: SizedBox(
        height: 48.h,
        child: TextFormField(
          canRequestFocus: false,
          keyboardType: TextInputType.none,
          controller: dateController,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_month_rounded),
              onPressed: () async {
                dynamic date = await showDatePicker(
                    context: context,
                    firstDate:
                    DateTime(DateTime.now().year - 1),
                    lastDate: DateTime(2099));
                dateController.text =
                    DateFormat.yMMMMd().format(date);
              },
            ),
            label: const Text("Transaction Date"),
            hintText: dateController.text,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
        ),
      ),
    );
  }
}

