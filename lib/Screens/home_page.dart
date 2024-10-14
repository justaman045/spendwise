import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendwise/Components/available_balance.dart';
import 'package:spendwise/Components/current_flow.dart';
import 'package:spendwise/Components/custom_appbar.dart';
import 'package:spendwise/Components/custom_drawer.dart';
import 'package:spendwise/Components/recent_transaction_header.dart';
import 'package:spendwise/Components/transaction_widget.dart';
import 'package:spendwise/Models/cus_transaction.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Requirements/transaction.dart';
import 'package:spendwise/Screens/cash_entry.dart';
import 'package:spendwise/Utils/methods.dart';
import 'package:spendwise/Utils/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Local Variable Declaration to use it in rendering
  List<CusTransaction> bankTransaction = [];
  // ignore: unused_field
  Future? _future;
  dynamic _user;
  dynamic username;

  // Function to run everytime a user expects to refresh the data but the value is not being used
  Future<void> _refreshData() async {
    setState(() {
      _future = getTransactions();
    });
  }

  // Get the User from the Server and update the Current User only if the User Data have been recived
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

    // Refresh Indicator for the homeScreen
    return RefreshIndicator(
      onRefresh: _refreshData,

      // Future Builder to build and render the screen once the data is loaded completely
      child: FutureBuilder(
        future: getTransactions(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // if the connection is done and the data is succesfully retirved then return the screen else return loading screen
          if ((snapshot.connectionState == ConnectionState.done) &&
              (_user != null)) {
            // put the loaded BankTransaction into a variable for furhter use of the rendering app
            bankTransaction = snapshot.data;

            // get the user and extract it's detail
            for (dynamic user in _user.docs) {
              if (user["email"].toString() ==
                  FirebaseAuth.instance.currentUser!.email) {
                username = user;
              }
            }

            // Render homepage screen
            return Scaffold(
              // Custom AppBar for this Page
              appBar: CustomAppBar(
                username: username["username"].toString(),
              ),
              // Drawer of the App
              drawer: CustomDrawer(
                username: username["username"].toString(),
                scaffoldKey: scaffoldKey,
              ),
              body: SafeArea(
                child: GestureDetector(
                  // Error of Refetching the Data when being clicked/touched on Today's Transaction HEader
                  // onVerticalDragEnd: (details) => _refreshData(),
                  child: Column(
                    children: [
                      // Available balance widget
                      AvailableBalance(
                        width: 300.h,
                        bankTransaction: bankTransaction,
                      ),

                      // Current FLow of the Money based on the type of flow
                      CurrentFlow(
                        bankTransactions: bankTransaction,
                      ),

                      // Header of the Transaction List
                      RecentTransactionHeader(
                        bankTransactions: bankTransaction,
                      ),

                      // if there are no transactions made today then show there are no transactions today
                      if (allTransactions(bankTransaction,
                              todayTrans: true, thisMonth: true)
                          .isEmpty) ...[
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // If there is no Transaction Recorded today then display a text of no transaction
                                Text(
                                  "No Transactions Today",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.r,
                                    color: Get.isDarkMode
                                        ? MyAppColors
                                            .normalColoredWidgetTextColorLightMode
                                        : MyAppColors
                                            .normalColoredWidgetTextColorDarkMode,
                                  ),
                                ),

                                // Display a Refresh button because if there is no transaction then it woun't refresh on drag
                                Padding(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: Container(
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

                            // Item builder with a list of Today's transaction of this month
                            itemBuilder: (context, index) {
                              final transaction = allTransactions(
                                  bankTransaction,
                                  thisMonth: true,
                                  todayTrans: true);

                              // Return the Transaction Widget with the transaction details
                              return TransactionWidget(
                                expenseType: transaction[index].expenseType,
                                amount: transaction[index].amount.toInt(),
                                dateAndTime: transaction[index].dateAndTime,
                                name: transaction[index].name,
                                typeOfTransaction:
                                    transaction[index].typeOfTransaction,
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
