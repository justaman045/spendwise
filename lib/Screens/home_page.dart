import 'package:flutter/material.dart';
import 'package:spendwise/Components/available_balance.dart';
import 'package:spendwise/Components/current_flow.dart';
import 'package:spendwise/Components/custom_appbar.dart';
import 'package:spendwise/Components/google_nav_bar_bottom.dart';
import 'package:spendwise/Components/recent_transaction_header.dart';
import 'package:spendwise/Components/transaction_widget.dart';
import 'package:spendwise/Requirements/transaction.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final todaysTransactions =
        transactions.where(isTransactionForToday).toList();

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            AvailableBalance(
              width: width,
              intakeamount: totalIncomeThisMonth().toInt(),
              expense: totalExpenseThisMonth().toInt(),
            ),
            CurrentFlow(
              width: width,
              income: totalIncomeThisMonth(),
              expense: totalExpenseThisMonth(),
            ),
            RecentTransactionHeader(width: width),
            if (todaysTransactions.isEmpty) ...[
              const Expanded(
                child: Center(
                  child: Text(
                    "No Transactions Today",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ] else ...[
              Expanded(
                child: ListView.builder(
                  itemCount: todaysTransactions
                      .length, // Use todaysTransactions length
                  itemBuilder: (context, index) {
                    final transaction = todaysTransactions[index];
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
            ]
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Icon(Icons.add),
        onPressed: () {},
      ),
      bottomNavigationBar: GoogleNavBarBottom(
        width: width,
        height: height,
      ),
    );
  }
}
