import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:get/get.dart';
import 'package:spendwise/Components/available_balance.dart';
import 'package:spendwise/Components/current_flow.dart';
import 'package:spendwise/Components/custom_appbar.dart';
import 'package:spendwise/Components/custom_drawer.dart';
import 'package:spendwise/Components/recent_transaction_header.dart';
import 'package:spendwise/Components/responsive_methods.dart';
import 'package:spendwise/Components/transaction_widget.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Requirements/transaction.dart';
import 'package:spendwise/Screens/cash_entry.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.bankTransaction});

  final List<SmsMessage> bankTransaction;

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    final todaysTransactions =
        transactions.where(isTransactionForToday).toList();
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: CustomDrawer(
        scaffoldKey: scaffoldKey,
        bankTransaction: bankTransaction,
      ),
      body: SafeArea(
        child: Column(
          children: [
            AvailableBalance(
              width: 300.h,
              intakeamount: totalIncomeThisMonth().toInt(),
              expense: totalExpenseThisMonth().toInt(),
            ),
            CurrentFlow(
              width: getScreenWidth(context),
              income: totalIncomeThisMonth(),
              expense: totalExpenseThisMonth(),
            ),
            RecentTransactionHeader(
              width: getScreenWidth(context),
            ),
            if (todaysTransactions.isEmpty) ...[
              Expanded(
                child: Center(
                  child: Text(
                    "No Transactions Today",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.r,
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
                      width: 100.w,
                      amount: transaction.amount,
                      dateAndTime: transaction.dateAndTime,
                      name: transaction.name,
                      typeOfTransaction: transaction.typeOfTransaction,
                      height: 100.h,
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
        onPressed: () {
          Get.to(
            routeName: routes[12],
            () => const AddCashEntry(),
            curve: customCurve,
            transition: customTrans,
            duration: duration,
          );
        },
      ),
    );
  }
}
