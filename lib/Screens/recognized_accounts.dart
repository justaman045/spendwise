import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendwise/Requirements/transaction.dart';

class RecognizedAccounts extends StatelessWidget {
  const RecognizedAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Wallets Recognized",
          style: TextStyle(fontSize: 15.r),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 15.h,
                left: 20.w,
              ),
              child: Text(
                "Primary Account",
                style: TextStyle(fontSize: 15.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.w),
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
                      Radius.circular(15.r),
                    ),
                  ),
                  width: 330.w,
                  height: 90.h,
                  child: Padding(
                    padding: EdgeInsets.all(20.r),
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_balance,
                          size: 25.r,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "***** ${accounts[0].accountNumber.toString().substring(accounts[0].accountNumber.toString().length - 5)}",
                                style: TextStyle(fontSize: 15.r),
                              ),
                              Text(
                                accounts[0].bankName,
                                style: TextStyle(
                                  fontSize: 13.r,
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
