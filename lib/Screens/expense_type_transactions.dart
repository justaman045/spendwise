import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendwise/Components/transaction_widget.dart';
import 'package:spendwise/Models/cus_transaction.dart';
import 'package:spendwise/Models/expense_type.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Utils/expense_type_methods.dart';
import 'package:spendwise/Utils/transaction_methods.dart';
import '../Components/transaction_charts.dart';

class ExpenseTypeTransactions extends StatefulWidget {
  const ExpenseTypeTransactions({super.key, required this.typeOfExpenseTitle});

  final ExpenseType typeOfExpenseTitle;

  @override
  State<ExpenseTypeTransactions> createState() =>
      _ExpenseTypeTransactionsState();
}

class _ExpenseTypeTransactionsState extends State<ExpenseTypeTransactions> {
  List<CusTransaction> cusTransaction = [];

  void _refreshData() async {
    List<CusTransaction>? transaction = await TransactionMethods()
        .getTransactionByType(widget.typeOfExpenseTitle.name);
    if (transaction != null) {
      setState(() {
        cusTransaction = transaction;
      });
    }
  }

  Future<void> _getFirstData() async {
    List<CusTransaction>? transaction = await TransactionMethods()
        .getTransactionByType(widget.typeOfExpenseTitle.name);
    if (transaction != null) {
      setState(() {
        cusTransaction = transaction;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _getFirstData();
    super.initState();
  }

  Future<void> _deleteExpenseType() async {
    // Delete transactions one by one (waiting for each deletion to complete)
    for (var transaction in cusTransaction) {
      await TransactionMethods()
          .deleteTransaction(transaction.transactionReferanceNumber);
    }

    // Delete the expense type after all transactions are deleted
    if (!typeOfExpense.contains(widget.typeOfExpenseTitle.name)) {
      await ExpenseTypeMethods()
          .deleteExpenseType(widget.typeOfExpenseTitle.id);
      Get.back(result: "refresh");
    } else {
      Get.snackbar("Error", "Default Expense Type cannot be deleted");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Type : ${widget.typeOfExpenseTitle.name}"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              if (await confirm(
                context,
                title: const Text('Confirm'),
                content: Text(
                    'Deleting Expense Type will also delete all Transactions under Expense Type ${widget.typeOfExpenseTitle.name.capitalize ?? widget.typeOfExpenseTitle.name}'),
                textOK: const Text('Yes'),
                textCancel: const Text('No'),
              )) {
                await _deleteExpenseType();
              }
            },
            icon: const Icon(CupertinoIcons.delete),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (cusTransaction.isEmpty) ...[
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: 250.w,
                    child: Text(
                      "No Transactions made under Expense type ${widget.typeOfExpenseTitle.name}",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ] else ...[
              TransactionCharts(
                chartTitle: widget.typeOfExpenseTitle.name.capitalize ??
                    widget.typeOfExpenseTitle.name,
                chartName: widget.typeOfExpenseTitle.name,
                chartData: cusTransaction,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount:
                      cusTransaction.length, // Use todayTransactions length
                  itemBuilder: (context, index) {
                    return TransactionWidget(
                      transaction: cusTransaction[index],
                      refreshData: _refreshData,
                    );
                  },
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
