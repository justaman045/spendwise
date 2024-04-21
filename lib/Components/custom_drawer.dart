import "package:flutter/material.dart";
import "package:flutter_sms_inbox/flutter_sms_inbox.dart";
import "package:get/get.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Requirements/transaction.dart";
import "package:spendwise/Screens/all_transactions.dart";
import "package:spendwise/Screens/home_page.dart";
import "package:spendwise/Screens/settings.dart";
import "package:spendwise/Screens/user_profile.dart";

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.bankTransaction,
    required this.scaffoldKey,
  });

  final List<SmsMessage> bankTransaction;
  final GlobalKey scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Drawer(
      elevation: width,
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromRGBO(210, 209, 254, 1),
                  Color.fromRGBO(243, 203, 237, 1),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.person_2_sharp),
                Column(
                  children: [
                    Text(userName),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            title: Center(
              child: Text(navBars[0]),
            ),
            onTap: () {
              if (ModalRoute.of(context)?.settings.name != "/") {
                // print(ModalRoute.of(context)?.settings.name);
                Get.to(
                  routeName: "/",
                  () => HomePage(bankTransaction: bankTransaction),
                  curve: customCurve,
                  transition: customTrans,
                  duration: duration,
                );
              }
            },
          ),
          ListTile(
            title: Center(
              child: Text(navBars[1]),
            ),
            onTap: () {
              if (ModalRoute.of(context)?.settings.name != routes[4]) {
                // print(ModalRoute.of(context)?.settings.name);

                Get.to(
                  routeName: routes[4],
                  () => AllTransactions(
                    pageTitle: "All Transactions",
                    chartTitle: "All Transactions from SMS",
                    chartType: "Transaction",
                    transactioncustom: transactions,
                  ),
                  curve: customCurve,
                  transition: customTrans,
                  duration: duration,
                );
              }
            },
          ),
          ListTile(
            title: Center(
              child: Text(navBars[2]),
            ),
            onTap: () {
              if (ModalRoute.of(context)?.settings.name != routes[6]) {
                Get.to(
                  routeName: routes[6],
                  () => const UserProfile(),
                  curve: customCurve,
                  transition: customTrans,
                  duration: duration,
                );
              }
            },
          ),
          ListTile(
            title: Center(
              child: Text(navBars[3]),
            ),
            onTap: () {
              if (ModalRoute.of(context)?.settings.name != routes[7]) {
                Get.to(
                  routeName: routes[7],
                  () => const Settings(),
                  curve: customCurve,
                  transition: customTrans,
                  duration: duration,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
