import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/Models/people_expense.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Requirements/transaction.dart';
import 'package:spendwise/Screens/home_page.dart';
import 'package:spendwise/Utils/people_balance_shared_methods.dart';

//TODO: Finalize the page

final _formKey = GlobalKey<FormState>();

class AddPeople extends StatefulWidget {
  const AddPeople({super.key});

  static const _minNameLength = 4;

  @override
  State<AddPeople> createState() => _AddPeopleState();
}

class _AddPeopleState extends State<AddPeople> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final amountController = TextEditingController();
    final dateTimeController = TextEditingController();
    final transactionForController = TextEditingController();
    final relationController = TextEditingController();

    // final expensetype = <ExpenseType>[];

    // Future<void> fetchData() async {
    //   expensetype.clear();
    //   expensetype.addAll(await ExpenseTypeMethods().getAllExpenseTypes());
    //   setState(() {});
    // }
    //
    // @override
    // void initState() {
    //   super.initState();
    //   fetchData();
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add People/Friends"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // Use SingleChildScrollView for scrollable content
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w, top: 10.h, bottom: 10.h),
              child: Text(
                "Enter the People/Friends Details",
                style: TextStyle(fontSize: 17.r),
              ),
            ),
            // ------------------------------------------------------------------------
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: TextFormField(
                      controller: nameController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z ]')), // Allow spaces for full names
                      ],
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Add a Recipient name";
                        } else if (value!.length < AddPeople._minNameLength) {
                          return "Name must be at least ${AddPeople._minNameLength} characters";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.h),
                        ),
                      ),
                    ),
                  ),
                  // ----------------------------------------------------------------------------
                  // Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 10.h),
                  //   child: TextFormField(
                  //     controller: amountController,
                  //     keyboardType: TextInputType.number,
                  //     validator: (value) {
                  //       if (value?.isEmpty ?? true) {
                  //         return "Please enter a Amount";
                  //       } else if (int.parse(value!).isLowerThan(1)) {
                  //         return "Enter a Number greater than 0";
                  //       }
                  //       return null;
                  //     },
                  //     decoration: InputDecoration(
                  //       labelText: "Amount",
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(15.h),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // -----------------------------------------------------------------------
                  // Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 10.h),
                  //   child: TextFormField(
                  //     controller: dateTimeController,
                  //     canRequestFocus: false,
                  //     keyboardType: TextInputType.none,
                  //     readOnly: true,
                  //     decoration: InputDecoration(
                  //       labelText: "Date and Time",
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(15.h),
                  //       ),
                  //       suffixIcon: IconButton(
                  //         icon: const Icon(Icons.calendar_month_rounded),
                  //         onPressed: () async {
                  //           dynamic date = await showDatePicker(
                  //               context: context,
                  //               firstDate: DateTime(DateTime.now().year - 1),
                  //               lastDate: DateTime(2099));
                  //           dateTimeController.text =
                  //               DateFormat.yMMMMd().format(date);
                  //         },
                  //       ),
                  //       hintText: dateTime.toString(),
                  //     ),
                  //     validator: (value) {
                  //       if (value?.isEmpty ?? true) {
                  //         return "Add a Date for the Transaction";
                  //       }
                  //       return null;
                  //     },
                  //   ),
                  // ),
                  // -----------------------------------------------------------------------
                  // Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 10.h),
                  //   child: DropdownButtonFormField(
                  //     onChanged: (value) {
                  //       transactionForController.text = "dummy";
                  //     },
                  //     items: expensetype
                  //         .map((elem) => DropdownMenuItem(
                  //               value: elem.name,
                  //               child: Text(elem.name),
                  //             ))
                  //         .toList(),
                  //     decoration: InputDecoration(
                  //       labelText: "Transaction For",
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(15.h),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // -----------------------------------------------------------------------
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: TextFormField(
                      controller: relationController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z ]')), // Allow spaces for full names
                      ],
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Add a Relation";
                        } else if (value!.length < AddPeople._minNameLength) {
                          return "Relation must be at least ${AddPeople._minNameLength} characters";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Relation",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.h),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // -----------------------------------------------------------------------
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
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
                        amountController.text = "0";
                        dateTimeController.text =
                            DateFormat.yMMMMd().format(DateTime.now());
                        transactionForController.text = "";
                        if (_formKey.currentState!.validate()) {
                          PeopleBalance peopleBalance = PeopleBalance(
                            name: nameController.text,
                            amount: double.parse(amountController.text),
                            dateAndTime: dateTimeController.text,
                            transactionFor: transactionForController.text,
                            relationFrom: relationController.text,
                            transactionReferanceNumber:
                                generateUniqueRefNumber(),
                          );
                          PeopleBalanceSharedMethods()
                              .insertPeopleBalance(peopleBalance)
                              .then(
                                (value) => Get.offAll(() => const HomePage(),
                                    curve: customCurve,
                                    duration: duration,
                                    transition: customTrans),
                              );
                        }
                      },
                      child: Text(
                        "Add Person",
                        style: TextStyle(fontSize: 15.r),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
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
                        Get.back(result: "refresh");
                      },
                      child: const Text("Go Back"),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
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
                      amountController.text = "0";
                      dateTimeController.text =
                          DateFormat.yMMMMd().format(DateTime.now());
                      transactionForController.text = "";
                      if (_formKey.currentState!.validate()) {
                        PeopleBalance peopleBalance = PeopleBalance(
                          name: nameController.text,
                          amount: double.parse(amountController.text),
                          dateAndTime: dateTimeController.text,
                          transactionFor: transactionForController.text,
                          relationFrom: relationController.text,
                          transactionReferanceNumber: generateUniqueRefNumber(),
                        );
                        PeopleBalanceSharedMethods()
                            .insertPeopleBalance(peopleBalance)
                            .then(
                              (value) => Get.to(() => const AddPeople(),
                                  curve: customCurve,
                                  duration: duration,
                                  transition: customTrans),
                            );
                      }
                    },
                    child: Text(
                      "Add Another Person",
                      style: TextStyle(fontSize: 15.r),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
