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
import 'package:spendwise/Models/cus_transaction.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Requirements/transaction.dart';
import 'package:spendwise/Screens/cash_entry.dart';
import 'package:spendwise/Utils/methods.dart';

// TODO: Reduce Lines of Code
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CusTransaction> bankTransaction = [];
  Future? _future;
  dynamic _user;
  dynamic username;

  // Function to run everytime a user expects to refresh the data
  Future<void> _refreshData() async {
    setState(() {
      _future = getTransactions();
    });
  }

  Future<void> _getData() async {
    dynamic getUserData = await getUser();
    if (_user == null) {
      setState(() {
        _user = getUserData;
      });
    }
  }

  // Override default method to get the initial data beforehand only
  @override
  void initState() {
    // _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    _getData();

    return RefreshIndicator(
      onRefresh: _refreshData,
      child: FutureBuilder(
        future: getTransactions(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // if the connection is done and the data is succesfully retirved then return the screen else return loading screen
          if ((snapshot.connectionState == ConnectionState.done) &&
              (_user != null)) {
            bankTransaction = snapshot.data;
            // debugPrint(_user.docs.toString());
            // bankTransaction = snapshot.data[1];
            for (dynamic user in _user.docs) {
              if (user["email"].toString() ==
                  FirebaseAuth.instance.currentUser!.email) {
                username = user;
              }
            }

            // return homepage screen
            return Scaffold(
              appBar: CustomAppBar(
                username: userName.toString(),
              ),
              drawer: CustomDrawer(
                scaffoldKey: scaffoldKey,
              ),
              body: SafeArea(
                child: GestureDetector(
                  // onVerticalDragEnd: (details) => _refreshData(),
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

                      // if there are no transactions made today then show there are no transactions today
                      if (allTransactions(bankTransaction).isEmpty) ...[
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

                        // else show all the transactions made today
                      ] else ...[
                        Expanded(
                          child: ListView.builder(
                            // reverse: true,
                            itemCount: allTransactions(bankTransaction,
                                    thisMonth: true, todayTrans: true)
                                .length, // Use todaysTransactions length
                            itemBuilder: (context, index) {
                              final transaction = allTransactions(
                                  bankTransaction,
                                  thisMonth: true,
                                  todayTrans: true);
                              return TransactionWidget(
                                expenseType: transaction[index].expenseType,
                                width: 100.w,
                                amount: transaction[index].amount.toInt(),
                                dateAndTime: transaction[index].dateAndTime,
                                name: transaction[index].name,
                                typeOfTransaction:
                                    transaction[index].typeOfTransaction,
                                height: 100.h,
                                transactionReferanceNumber: transaction[index]
                                    .transactionReferanceNumber,
                                toIncl: transaction[index].toInclude,
                              );
                            },
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ),

              // a floating action button to add the cash entry
              floatingActionButton: FloatingActionButton.extended(
                label: const Icon(Icons.add),
                onPressed: () async {
                  final toreload = await Get.to(
                    routeName: routes[12],
                    () => const AddCashEntry(),
                    curve: customCurve,
                    transition: customTrans,
                    duration: duration,
                  );

                  if (toreload != null) {
                    // debugPrint(toreload.toString());
                    _refreshData();
                  }
                },
              ),
            );

            // loading screen to only show while the connection is waiting
          } else {
            return Scaffold(
              body: SafeArea(
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    SizedBox(
                      height: 10.r,
                    ),
                    const Text("Loading User Data"),
                  ],
                )),
              ),
            );
          }
        },
      ),
    );
  }
}
