import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:spendwise/Models/expense_type.dart';
import 'package:spendwise/Models/people_expense.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Requirements/transaction.dart';
import 'package:spendwise/Screens/home_page.dart';
import 'package:spendwise/Utils/expense_type_methods.dart';
import 'package:spendwise/Utils/people_balance_shared_methods.dart';

//TODO: Finalize the page

final _formKey = GlobalKey<FormState>();

class AddExpenseType extends StatefulWidget {
  const AddExpenseType({super.key});

  static const _minNameLength = 4;

  @override
  State<AddExpenseType> createState() => _AddExpenseTypeState();
}

class _AddExpenseTypeState extends State<AddExpenseType> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Expense Type"),
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
                "Enter the Expense Type Details",
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
                          return "Add a Expense Type name";
                        } else if (value!.length <
                            AddExpenseType._minNameLength) {
                          return "Type Name must be at least ${AddExpenseType._minNameLength} characters";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Expense Type Name",
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
                        if(_formKey.currentState!.validate()){
                          ExpenseTypeMethods().createExpenseType(ExpenseType(name: nameController.text, amount: 0)).then((value) => Get.back(result: "refresh"));
                        }
                      },
                      child: Text(
                        "Add Expense Type",
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
                      if (_formKey.currentState!.validate()) {
                        ExpenseType expenseType = ExpenseType(name: nameController.text, amount: 0);
                        ExpenseTypeMethods()
                            .createExpenseType(expenseType)
                            .then(
                              (value) => Get.to(() => const AddExpenseType(),
                                  curve: customCurve,
                                  duration: duration,
                                  transition: customTrans),
                            );
                        nameController.text = "";
                      }
                    },
                    child: Text(
                      "Add Another Expense Type",
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
