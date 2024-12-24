import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendwise/Models/expense_type.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Requirements/transaction.dart';
import 'package:spendwise/Screens/add_expense_type.dart';
import 'package:spendwise/Screens/expense_type_transactions.dart';
import 'package:spendwise/Utils/expense_type_methods.dart';

class SpendsByType extends StatefulWidget {
  const SpendsByType({super.key});

  @override
  State<SpendsByType> createState() => _SpendsByTypeState();
}

class _SpendsByTypeState extends State<SpendsByType> {
  Future<void> _refreshData() async {
    List<ExpenseType> fetchedExpenseTypes =
        await ExpenseTypeMethods().getAllExpenseTypes();

    List<ExpenseType> defaultExpenseTypes = typeOfExpense
        .map((expense) => ExpenseType(name: expense, amount: 0))
        .toList();

    setState(() {
      _expenseTypes = [...fetchedExpenseTypes, ...defaultExpenseTypes];
    });
  }

  List<ExpenseType> _expenseTypes = [];

  @override
  void initState() {
    super.initState();
    _fetchExpenseTypes();
  }

  Future<void> _fetchExpenseTypes() async {
    try {
      List<ExpenseType> fetchedExpenseTypes =
          await ExpenseTypeMethods().getAllExpenseTypes();
      List<ExpenseType> defaultExpenseTypes = typeOfExpense
          .map((expense) => ExpenseType(name: expense, amount: 0))
          .toList();

      setState(() {
        _expenseTypes = [...fetchedExpenseTypes, ...defaultExpenseTypes];
      });
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(CupertinoIcons.left_chevron)),
              Padding(
                padding: EdgeInsets.only(left: 30.w, bottom: 15.h),
                child: Text(
                  "Classify Transactions",
                  style: TextStyle(fontSize: 25.r),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Text(
                  "Classify your Transaction in a particular Category",
                  style: TextStyle(fontSize: 15.r),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.h,
                      crossAxisSpacing: 10.w,
                      childAspectRatio: 3 / 2,
                    ),
                    itemCount: _expenseTypes.length,
                    itemBuilder: (context, index) {
                      final expenseType = _expenseTypes[index];
                      return _buildExpenseTypeCard(
                          expenseType); // Call a method to build the card widget
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Icon(Icons.add),
        onPressed: () async {
          final reload = await Get.to(
            routeName: "addExpenseType",
            () => const AddExpenseType(),
            curve: customCurve,
            transition: customTrans,
            duration: duration,
          );

          if (reload != null) {
            _refreshData();
          }
        },
      ),
    );
  }

  Widget _buildExpenseTypeCard(ExpenseType expenseType) {
    // Implement the logic to display expense type information in a card
    // You can use Text, Icon, or other widgets as needed
    return GestureDetector(
      onTap: () async {
        dynamic toRefresh = Get.to(
          curve: customCurve,
          transition: customTrans,
          duration: duration,
          () => ExpenseTypeTransactions(
            typeOfExpenseTitle: expenseType,
          ),
        );
        if (toRefresh == "refresh") {
          setState(() {
            _refreshData();
          });
        }
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(getIconData(expenseType.name)),
              SizedBox(height: 10.h),
              Text(expenseType.name),
            ],
          ),
        ),
      ),
    );
  }
}
