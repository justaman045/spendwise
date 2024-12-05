import 'package:flutter/material.dart';
import 'package:spendwise/Models/people_expense.dart';
import 'package:spendwise/Utils/people_balance_shared_methods.dart';

class PeopleTransactions extends StatefulWidget {
  const PeopleTransactions({super.key, required this.peopleBalance});

  final PeopleBalance peopleBalance;

  @override
  State<PeopleTransactions> createState() => _PeopleTransactionsState();
}

Future<List<PeopleBalance>> getTransactions(String name) async{
  List<PeopleBalance> balance = await PeopleBalanceSharedMethods().getPeopleBalanceByName(name);
  for (var value in balance) {
    debugPrint(value.amount.toString());
  }
  return balance;
}

class _PeopleTransactionsState extends State<PeopleTransactions> {
  @override
  Widget build(BuildContext context) {
    getTransactions(widget.peopleBalance.name);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${widget.peopleBalance.name} Transactions"),
      ),
      body: Center(
        child: Text(widget.peopleBalance.name),
      ),
    );
  }
}
