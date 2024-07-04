import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Utils/theme.dart';
import 'package:spendwise/Models/db_helper.dart';

class SuscriptionManagerExpense extends StatefulWidget {
  const SuscriptionManagerExpense({
    super.key,
    required this.getSubs,
  });

  final Function getSubs;

  @override
  State<SuscriptionManagerExpense> createState() =>
      _SuscriptionManagerExpenseState();
}

class _SuscriptionManagerExpenseState extends State<SuscriptionManagerExpense> {
  List<dynamic> subscriptions = [];
  double expense = 0;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        subscriptions = await widget.getSubs();
        setState(() {});
      },
      child: FutureBuilder(
        future: widget.getSubs(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (ConnectionState.done == snapshot.connectionState) {
            getAllExpense() {
              List<Subscription> subs =
                  snapshot.data!; // Use null-aware operator

              // ignore: unnecessary_null_comparison
              if (subs != null) {
                double totalExpense = 0; // Initialize totalExpense to 0
                for (var subscription in subs) {
                  try {
                    totalExpense += subscription.amount; // Attempt parsing
                  } on FormatException {
                    // Handle parsing error (e.g., log the error)
                    debugPrint(
                        "Error parsing subscription amount: ${subscription.amount}");
                  }
                }
                expense =
                    totalExpense; // Update Expense with the calculated total
              }
            }

            getAllExpense();

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 10.h,
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: MyAppColors.avaiableBalanceColor,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Rs. ",
                            style: TextStyle(
                              fontSize: 15.r,
                              color: MyAppColors
                                  .normalColoredWidgetTextColorDarkMode,
                            ),
                          ),
                          Countup(
                            duration: duration,
                            begin: 0,
                            end: expense,
                            style: TextStyle(
                              fontSize: 25.r,
                              color: MyAppColors
                                  .normalColoredWidgetTextColorDarkMode,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        "Subscription Expense this Month",
                        style: TextStyle(
                          color:
                              MyAppColors.normalColoredWidgetTextColorDarkMode,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
