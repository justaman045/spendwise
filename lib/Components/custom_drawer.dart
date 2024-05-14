import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Screens/all_transactions.dart";
import "package:spendwise/Screens/home_page.dart";
import "package:spendwise/Screens/settings.dart";
import "package:spendwise/Screens/user_profile.dart";

// TODO: Reduce Lines of Code
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.scaffoldKey,
  });

  // a local variable to recive scaffold key to build a custom drawer of the app
  final GlobalKey scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250.w,
      elevation: 10.h,
      child: ListView(
        children: [
          // header of the drawer
          // TODO : Edit the Drawer Header to a more meaningfull header
          DrawerHeader(
            decoration: const BoxDecoration(
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
                const Icon(Icons.person_2_sharp),
                Column(
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: 20.w,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Routes and buttons of the app Drawer
          ListTile(
            title: Center(
              child: Text(
                navBars[0],
                style: TextStyle(fontSize: 15.w),
              ),
            ),
            onTap: () {
              if (ModalRoute.of(context)?.settings.name != "/") {
                Get.to(
                  routeName: "/",
                  () => const HomePage(),
                  curve: customCurve,
                  transition: customTrans,
                  duration: duration,
                );
              }
            },
          ),
          ListTile(
            title: Center(
              child: Text(
                navBars[1],
                style: TextStyle(fontSize: 15.w),
              ),
            ),
            onTap: () {
              if (ModalRoute.of(context)?.settings.name != routes[4]) {
                Get.to(
                  routeName: routes[4],
                  () => const AllTransactions(
                    type: "allTransactions",
                    pageTitle: "All Transactions",
                    chartTitle: "All Transactions from SMS",
                    chartType: "Transaction",
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
              child: Text(
                navBars[2],
                style: TextStyle(
                  fontSize: 15.w,
                ),
              ),
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
              child: Text(
                navBars[3],
                style: TextStyle(
                  fontSize: 15.w,
                ),
              ),
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
