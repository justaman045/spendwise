import 'package:flutter/material.dart';
import 'package:spendwise/Requirements/transaction.dart';

class RecognizedAccounts extends StatelessWidget {
  const RecognizedAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallets Recognized"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: height * 0.02,
                left: width * 0.05,
              ),
              child: const Text("Primary Account"),
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.03),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromRGBO(210, 209, 254, 1),
                        Color.fromRGBO(243, 203, 237, 1),
                      ],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(width * 0.03),
                    ),
                  ),
                  width: width * 0.9,
                  height: height * 0.11,
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.04),
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_balance,
                          size: width * 0.08,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: width * 0.04,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "***** ${accounts[0].accountNumber.toString().substring(accounts[0].accountNumber.toString().length - 5)}",
                                style: TextStyle(fontSize: height * 0.02),
                              ),
                              Text(
                                accounts[0].bankName,
                                style: TextStyle(
                                  fontSize: height * 0.018,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
