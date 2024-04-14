import 'package:flutter/material.dart';
import 'package:spendwise/Components/available_balance.dart';
import 'package:spendwise/Components/current_flow.dart';
import 'package:spendwise/Components/recent_transaction_header.dart';
import 'package:spendwise/Components/transaction_widget.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Requirements/transaction.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final todaysTransactions =
        transactions.where(isTransactionForToday).toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: width * 0.5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.pink.shade400,
                      borderRadius: BorderRadius.all(
                        Radius.circular(width * 0.2),
                      ),
                    ),
                    width: width * 0.1,
                    height: height * 0.05,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.pink.shade400,
                    borderRadius: BorderRadius.all(
                      Radius.circular(width * 0.2),
                    ),
                  ),
                  width: width * 0.4,
                  height: height * 0.2,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.09, top: height * 0.04),
              child: const Text(
                "Login",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.09, top: height * 0.01),
              child: const Text(
                "Please Sign in to Continue",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.07,
                vertical: height * 0.04,
              ),
              child: TextFormField(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.07,
                vertical: height * 0.01,
              ),
              child: TextFormField(),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.75,
                top: height * 0.05,
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius:
                        BorderRadius.all(Radius.circular(width * 0.035))),
                width: width * 0.2,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, routes[3]);
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
