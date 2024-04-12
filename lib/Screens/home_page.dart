import 'package:flutter/material.dart';
import 'package:spendwise/Components/available_balance.dart';
import 'package:spendwise/Components/current_flow.dart';
import 'package:spendwise/Components/recent_transaction_header.dart';
import 'package:spendwise/Components/transaction.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Requirements/transaction.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome, $userName"),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.supervised_user_circle_outlined),
          onPressed: () {},
          tooltip: "Menu Icon",
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.wallet),
            tooltip: "Wallets Recognised",
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            AvailableBalance(width: width),
            CurrentFlow(width: width),
            RecentTransactionHeader(width: width),
            Expanded(
              // Wrap the ListView with Expanded for full height
              child: ListView.builder(
                itemCount: transactions.length, // Replace with your data source
                itemBuilder: (context, index) {
                  final transaction =
                      transactions[index]; // Access data at index
                  return TransactionWidget(
                    width: width,
                    amount: transaction.amount,
                    dateAndTime: transaction.dateAndTime,
                    name: transaction.name,
                    typeOfTransaction: transaction.typeOfTransaction,
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
