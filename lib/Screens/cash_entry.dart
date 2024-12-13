import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:multi_dropdown/multi_dropdown.dart";
import "package:spendwise/Models/people_expense.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Requirements/transaction.dart";
import "package:spendwise/Screens/add_people.dart";
import "package:spendwise/Utils/methods.dart";
import "package:spendwise/Utils/people_balance_shared_methods.dart";
import "package:spendwise/Utils/theme.dart";
import "package:spendwise/Utils/utils.dart";
import "package:spendwise/Components/custom_text_box.dart";
import "package:spendwise/Components/date_text_box.dart";
import "package:spendwise/Components/option_box.dart";

import "../Components/option_check_box.dart";

// TODO: Reduce Lines of Code
final _formKey = GlobalKey<FormState>();

class AddCashEntry extends StatefulWidget {
  const AddCashEntry({super.key});

  static const route = '/cash-entry';

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
  String typeOfExp = "";
  String typeOftransaction = "";
  String transactionReferanceNumber = "";
  DateTime? recurringDate;
  bool isSharable = false;
  bool toAddNewPerson = false;
  bool toIncludeYourself = false;
  bool pastDateTransaction = false;
  MultiSelectController<String> multiSelectDropDownController =
      MultiSelectController<String>();
  List<PeopleBalance> _peopleBalanceList = [];
  List<PeopleBalance> people = [];
  double updatedAmount = 0;
  DateTime? fromdate;

  Future<void> _fetchData() async {
    _peopleBalanceList = await PeopleBalanceSharedMethods().getPeopleNames();
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
                        typeOfExp = newValue!;
                      }),
                      items: getDropDownMenuItems(typeOfExpense),
                      labelString: "Type Of Expense",
                    ),
                    OptionBox(
                      function: (String? value) => setState(
                        () {
                          if (value != null) {
                            typeOftransactionEditingController.text = value;
                            if (![
                              typeOfTransaction[0].toLowerCase(),
                              typeOfTransaction[1].toLowerCase()
                            ].contains(typeOftransactionEditingController.text
                                .toLowerCase())) {
                              isSharable = true;
                            } else {
                              isSharable = false;
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
                    if (isSharable) ...[
                      OptionCheckBox(
                          stringLabel:
                              "If the person is not available in the list, Click here",
                          dataValue: toAddNewPerson,
                          function: (value) {
                            setState(
                              () {
                                toAddNewPerson = value!;
                              },
                            );
                          }),
                      if (toAddNewPerson == false) ...[
                        //TODO: to look into future
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
                                : _peopleBalanceList.length,
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
                              //TODO: To make amount of person non changeable when it's about managing people balance
                            },
                          ),
                        ),
                      ] else ...[
                        GestureDetector(
                          onTap: () async {
                            final reload = await Get.to(
                              routeName: "add_people",
                              () => const AddPeople(),
                              curve: customCurve,
                              transition: customTrans,
                              duration: duration,
                            );

                            if (reload != null) {
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
                    if ((isSharable == true) && (toAddNewPerson == false)) ...[
                      OptionCheckBox(
                        stringLabel:
                            "Click here to divide the amount between only the selected Persons",
                        dataValue: toIncludeYourself,
                        function: (bool? value) {
                          setState(
                            () {
                              toIncludeYourself = value!;
                            },
                          );
                        },
                      ),
                    ],
                    OptionCheckBox(
                      stringLabel:
                          "Click here to add a Date Of the Transaction",
                      dataValue: pastDateTransaction,
                      function: (bool? value) {
                        setState(
                          () {
                            pastDateTransaction = value!;
                          },
                        );
                      },
                    )
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
                          //TODO: feature to save and add transactions
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
                          //TODO: add the transaction based on different income/expense
                          if ([typeOfTransaction[0].toLowerCase(), typeOfTransaction[1].toString()].contains(typeOftransactionEditingController.text.toLowerCase())) {
                            bool inserted = await addIncomeAndExpense(
                                nameEditingController.text,
                                amountEditingController.text,
                                typeOfExp,
                                fromDate.text,
                                pastDateTransaction,
                                typeOftransactionEditingController.text,
                            );
                            if (inserted) {
                              Get.back(result: "refresh");
                            } else {
                              Get.snackbar("Internal Error",
                                  "Your Transaction wasn't saved");
                            }
                          } else if([typeOfTransaction[2].toLowerCase(), typeOfTransaction[3].toLowerCase()].contains(typeOftransactionEditingController.text.toLowerCase())){
                            debugPrint("Yes");
                            bool inserted = await addSharedIncomeAndExpense(
                              nameEditingController.text,
                              amountEditingController.text,
                              typeOfExp,
                              typeOftransactionEditingController.text,
                              multiSelectDropDownController.selectedItems,
                              toIncludeYourself,
                              fromDate.text,
                              pastDateTransaction
                            );
                            if (inserted) {
                              Get.back(result: "refresh");
                            } else {
                              Get.snackbar("Internal Error",
                                  "Your Transaction wasn't saved");
                            }
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
