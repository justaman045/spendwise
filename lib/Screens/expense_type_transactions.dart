import 'package:flutter/material.dart';
import 'package:spendwise/Components/transaction_widget.dart';
import 'package:spendwise/Models/cus_transaction.dart';
import 'package:spendwise/Models/expense_type.dart';
import 'package:spendwise/Utils/transaction_methods.dart';
import '../Components/transaction_charts.dart';

class ExpenseTypeTransactions extends StatefulWidget {
  const ExpenseTypeTransactions({super.key, required this.typeOfExpenseTitle});

  final ExpenseType typeOfExpenseTitle;

  @override
  State<ExpenseTypeTransactions> createState() => _ExpenseTypeTransactionsState();
}

class _ExpenseTypeTransactionsState extends State<ExpenseTypeTransactions> {
  List<CusTransaction> cusTransaction = [];

  void _refreshData() async {
    List<CusTransaction>? transaction = await TransactionMethods().getTransactionByType(widget.typeOfExpenseTitle.name);
    if(transaction != null){
      setState(() {
        cusTransaction = transaction;
      });
    }
  }

  Future<void> _getFirstData() async {
    List<CusTransaction>? transaction = await TransactionMethods().getTransactionByType(widget.typeOfExpenseTitle.name);
    if(transaction != null){
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TransactionCharts(
              chartTitle: "Test Chart Title",
              chartName: "Test Chart Name",
              chartData: cusTransaction,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cusTransaction
                    .length, // Use todayTransactions length
                itemBuilder: (context, index) {
                  return TransactionWidget(
                    transaction: cusTransaction[index],
                    refreshData: _refreshData,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
