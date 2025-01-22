import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/Models/cus_transaction.dart';
import 'package:spendwise/Models/people_expense.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Requirements/transaction.dart';
import 'package:spendwise/Screens/people_transaction_details.dart';
import 'package:spendwise/Utils/methods.dart';
import 'package:spendwise/Utils/people_balance_shared_methods.dart';
import 'package:spendwise/Utils/transaction_methods.dart';

class PeopleTransactions extends StatefulWidget {
  const PeopleTransactions({super.key, required this.peopleBalance});

  final PeopleBalance peopleBalance;

  @override
  State<PeopleTransactions> createState() => _PeopleTransactionsState();
}

double amount = 0;

Future<List<PeopleBalance>> getTransactions(String name) async {
  List<PeopleBalance> balance =
      await PeopleBalanceSharedMethods().getPeopleBalanceByName(name);
  amount = await PeopleBalanceSharedMethods()
      .calculateFinalAmountSingleUser(balance);
  return balance.reversed.toList();
}

class _PeopleTransactionsState extends State<PeopleTransactions> {
  Future<void> _refreshData() async {
    List<PeopleBalance> balance = await PeopleBalanceSharedMethods()
        .getPeopleBalanceByName(widget.peopleBalance.name);
    setState(() {
      balance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getTransactions(widget.peopleBalance.name),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (ConnectionState.done == snapshot.connectionState) {
          return RefreshIndicator(
            onRefresh: _refreshData,
            child: Scaffold(
              appBar: AppBar(
                title: Text("${widget.peopleBalance.name} Transactions"),
                centerTitle: true,
                actions: [
                  if (!amount.isEqual(0)) ...[
                    IconButton(
                      onPressed: () async {
                        if (await confirm(
                          context,
                          title: const Text(
                              "Are you sure, You want to mark it as Paid?"),
                          content: Text(
                              "This will mark ${widget.peopleBalance.name}'s Transaction as Balanced"),
                          textOK: const Text("Mark it as Paid"),
                        )) {
                          PeopleBalance peopleBalance = PeopleBalance(
                            name: widget.peopleBalance.name,
                            amount: (amount * -1),
                            dateAndTime:
                                DateFormat.yMMMMd().format(DateTime.now()),
                            transactionFor:
                                "Balancing ${widget.peopleBalance.name} Transaction",
                            relationFrom: widget.peopleBalance.relationFrom,
                            transactionReferanceNumber:
                                generateUniqueRefNumber(),
                          );
                          await PeopleBalanceSharedMethods()
                              .insertPeopleBalance(
                            peopleBalance,
                          );
                          if (amount.isNegative) {
                            TransactionMethods().insertTransaction(
                              CusTransaction(
                                amount: (amount * -1),
                                dateAndTime: stringToDateTime(peopleBalance.dateAndTime),
                                name:
                                    "Balancing ${widget.peopleBalance.name} Amount",
                                typeOfTransaction: typeOfTransaction[1],
                                expenseType: typeOfExpense[9],
                                transactionReferanceNumber:
                                    peopleBalance.transactionReferanceNumber,
                              ),
                            );
                          } else if (amount.isGreaterThan(0)) {
                            TransactionMethods().insertTransaction(
                              CusTransaction(
                                amount: amount,
                                dateAndTime:
                                    stringToDateTime(peopleBalance.dateAndTime),
                                name:
                                    "Balancing ${widget.peopleBalance.name} Amount",
                                typeOfTransaction: typeOfTransaction[0],
                                expenseType: typeOfExpense[9],
                                transactionReferanceNumber:
                                    peopleBalance.transactionReferanceNumber,
                              ),
                            );
                          }
                          setState(() {});
                        }
                      },
                      icon: const Icon(CupertinoIcons.checkmark_rectangle),
                    ),
                  ]
                ],
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (snapshot.data.length > 0) ...[
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 10.h,
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                dynamic refresh = await Get.to(
                                  routeName: "Shared Transaction Details",
                                  () => PeopleTransactionDetails(
                                    transaction: snapshot.data[index],
                                  ),
                                  transition: customTrans,
                                  curve: customCurve,
                                  duration: duration,
                                );

                                if (refresh != null) {
                                  setState(() {
                                    _refreshData();
                                  });
                                }
                              },
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1.r),
                                      borderRadius: BorderRadius.circular(20.r),
                                      color: Colors.blueGrey,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.r),
                                      child: const Icon(Icons.payment_rounded),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 275.w,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(snapshot.data[index].name),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 150.w,
                                                    child: Text(
                                                        "Transaction made on ${snapshot.data[index].dateAndTime} for ${snapshot.data[index].transactionFor}"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 50.w,
                                            child: Text(
                                                "Rs. ${snapshot.data[index].amount.toString()}"),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              PeopleBalanceSharedMethods()
                                                  .deletePeopleBalance(snapshot
                                                      .data[index]
                                                      .transactionReferanceNumber)
                                                  .then(
                                                (value) {
                                                  _refreshData();
                                                },
                                              );
                                            },
                                            child: const Icon(Icons.delete),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ]
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
