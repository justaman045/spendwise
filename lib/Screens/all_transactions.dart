import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:spendwise/Components/transaction_charts.dart";
import "package:spendwise/Components/transaction_widget.dart";
import "package:spendwise/Requirements/transaction.dart";

class AllTransactions extends StatelessWidget {
  const AllTransactions({
    super.key,
    required this.transactioncustom,
    required this.pageTitle,
    required this.chartTitle,
    required this.chartType,
  });

  final List<Transaction> transactioncustom;
  final String pageTitle;
  final String chartTitle;
  final String chartType;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => {Get.back()},
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          TransactionCharts(
            chartTitleCustom: chartTitle,
            chartNameOne: chartType,
            chartOne: transactioncustom,
          ),
          Expanded(
            child: ListView.builder(
              itemCount:
                  transactioncustom.length, // Use todaysTransactions length
              itemBuilder: (context, index) {
                final transaction = transactioncustom[index];
                return TransactionWidget(
                  expenseType: transaction.expenseType,
                  width: width,
                  amount: transaction.amount,
                  dateAndTime: transaction.dateAndTime,
                  name: transaction.name,
                  typeOfTransaction: transaction.typeOfTransaction,
                  height: height,
                  transactionReferanceNumber:
                      transaction.transactionReferanceNumber,
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}