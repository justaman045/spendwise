import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendwise/Components/available_balance.dart';
import 'package:spendwise/Components/current_flow.dart';
import 'package:spendwise/Components/custom_appbar.dart';
import 'package:spendwise/Components/custom_drawer.dart';
import 'package:spendwise/Components/gradient_color.dart';
import 'package:spendwise/Components/recent_transaction_header.dart';
import 'package:spendwise/Components/responsive_methods.dart';
import 'package:spendwise/Components/transaction_widget.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Requirements/transaction.dart';
import 'package:spendwise/Screens/cash_entry.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future? _future;

  Future<dynamic> getData() async {
    final users = await FirebaseFirestore.instance.collection("Users").get();
    final bankTransactions = await querySmsMessages();
    debugPrint(bankTransactions.toString());
    return [users, bankTransactions];
  }

  Future<void> _refreshData() async {
    setState(() {
      _future = getData();
    });
  }

  @override
  void initState() {
    _future = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    List<CusTransaction> bankTransaction = [];

    return RefreshIndicator(
      onRefresh: _refreshData,
      child: FutureBuilder(
        future: _future,
        initialData: bankTransaction,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            bankTransaction = snapshot.data[1];
            // debugPrint(snapshot.data.toString());
            // bankTransaction = [];
            dynamic user;
            for (dynamic use in snapshot.data[0].docs) {
              if (use["email"].toString() ==
                  FirebaseAuth.instance.currentUser!.email) {
                user = use;
              }
            }
            return Scaffold(
              appBar: CustomAppBar(
                username: user["username"],
              ),
              drawer: CustomDrawer(
                scaffoldKey: scaffoldKey,
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    AvailableBalance(
                      width: 300.h,
                      bankTransaction: bankTransaction,
                    ),
                    CurrentFlow(
                      width: getScreenWidth(context),
                      bankTransactions: bankTransaction,
                    ),
                    RecentTransactionHeader(
                      bankTransactions: bankTransaction,
                      width: getScreenWidth(context),
                    ),
                    if (allTodaysTransactions(bankTransaction).isEmpty) ...[
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "No Transactions Today",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.r,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: colorsOfGradient(),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _refreshData();
                                    });
                                  },
                                  child: Text(
                                    "Refresh",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13.r,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ] else ...[
                      Expanded(
                        child: ListView.builder(
                          itemCount: allTodaysTransactions(bankTransaction)
                              .reversed
                              .toList()
                              .length, // Use todaysTransactions length
                          itemBuilder: (context, index) {
                            final transaction =
                                allTodaysTransactions(bankTransaction);
                            return TransactionWidget(
                              expenseType: transaction[index].expenseType,
                              width: 100.w,
                              amount: transaction[index].amount.toInt(),
                              dateAndTime: transaction[index].dateAndTime,
                              name: transaction[index].name,
                              typeOfTransaction:
                                  transaction[index].typeOfTransaction,
                              height: 100.h,
                              transactionReferanceNumber:
                                  transaction[index].transactionReferanceNumber,
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
          } else {
            return const Scaffold(
              body: SafeArea(
                child: Center(child: CircularProgressIndicator()),
              ),
            );
          }
        },
      ),
    );
  }
}
