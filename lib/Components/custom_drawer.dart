import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:showcaseview/showcaseview.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Screens/all_transactions.dart";
import "package:spendwise/Screens/features_to_impliment.dart";
import "package:spendwise/Screens/home_page.dart";
import "package:spendwise/Screens/people.dart";
import "package:spendwise/Screens/settings.dart";
import "package:spendwise/Screens/spends_by_type.dart";
import "package:spendwise/Screens/subscription.dart";
import "package:spendwise/Screens/user_profile.dart";
import "package:spendwise/Utils/theme.dart";
import "package:url_launcher/url_launcher.dart"; // Assuming MyAppColors is defined here

// Represents a custom drawer for the Spendwise app
class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
    required this.scaffoldKey,
    required this.username,
  });

  final String username;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _testerEnabled = false;

  Future<void> _loadTesterPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _testerEnabled = prefs.getBool('tester') ?? false;
    });
  }

  @override
  void initState() {
    _loadTesterPreference();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Static list of drawer item names
    final Map<String, IconData> navBars = {
      "Home": CupertinoIcons.home,
      "Transactions": const IconData(0xe040, fontFamily: 'MaterialIcons'),
      "Profile": Icons.person_2,
      "Subscriptions": Icons.subscriptions,
      "People": CupertinoIcons.group_solid,
      "Spends": CupertinoIcons.arrow_right_arrow_left,
      "Settings": CupertinoIcons.settings_solid,
      "Features yet to Implement": CupertinoIcons.tray_full,
      "Contact me for Feature Suggestion": Icons.contact_emergency,
    };

    return Drawer(
      width: 250.w,
      elevation: 10.h,
      child: ListView(
        children: [
          // Drawer Header (consider a custom widget for reusability)
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: MyAppColors.avaiableBalanceColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                    child: SizedBox(
                  width: 88.w,
                  child: const Image(image: AssetImage("assets/pfp/4.png")),
                )),
                Column(
                  children: [
                    Center(
                      child: Text(
                        widget.username, // Username of the user
                        style: TextStyle(
                          fontSize: 20.w,
                          color:
                              MyAppColors.normalColoredWidgetTextColorDarkMode,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Items of the NavBar
          for (int i = 0; i < navBars.length; i++)
            if (_testerEnabled || i < navBars.length - 2) ...[
              ListTile(
                leading: Icon(navBars.values.elementAt(i)),
                title: Text(
                  navBars.keys.elementAt(i),
                  style: TextStyle(fontSize: 15.w),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  _handleNavigation(context, i);
                },
              ),
            ]
        ],
      ),
    );
  }

  // Handles navigation based on the tapped drawer item index
  void _handleNavigation(BuildContext context, int index) async {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    switch (index) {
      case 0: // Home
        if (currentRoute != "/") {
          Get.to(
            routeName: "/",
            () => const HomePage(),
            curve: customCurve,
            transition: customTrans,
            duration: duration,
          );
        }
        break;
      case 1: // All Transactions
        if (currentRoute != routes[4]) {
          Get.to(
            routeName: routes[4],
            () => ShowCaseWidget(
              builder: (context) => const AllTransactions(
                pageTitle: "All Transactions",
                chartTitle: "All Transactions from SMS",
                chartType: "Transaction",
              ),
            ),
            curve: customCurve,
            transition: customTrans,
            duration: duration,
          );
        }
        break;
      case 2: // Profile
        if (currentRoute != routes[6]) {
          Get.to(
            routeName: routes[6],
            () => ShowCaseWidget(builder: (context) => const UserProfile()),
            curve: customCurve,
            transition: customTrans,
            duration: duration,
          );
        }
        break;
      case 3: // Subscriptions
        if (currentRoute != routes[13]) {
          Get.to(
            routeName: routes[13],
            () => ShowCaseWidget(
                builder: (context) => const SubscriptionManager()),
            curve: customCurve,
            transition: customTrans,
            duration: duration,
          );
        }
        break;
      case 4: // Settings
        if (currentRoute != "people") {
          Get.to(
            routeName: "people",
            () => ShowCaseWidget(builder: (context) => const People()),
            curve: customCurve,
            transition: customTrans,
            duration: duration,
          );
        }
        break;
      case 5: // Settings
        if (currentRoute != "spends") {
          Get.to(
            routeName: "spends",
            () => ShowCaseWidget(builder: (context) => const SpendsByType()),
            curve: customCurve,
            transition: customTrans,
            duration: duration,
          );
        }
        break;
      case 6: // Settings
        if (currentRoute != routes[7]) {
          Get.to(
            routeName: routes[7],
            () => ShowCaseWidget(builder: (context) => const Settings()),
            curve: customCurve,
            transition: customTrans,
            duration: duration,
          );
        }
        break;
      case 7: // Settings
        if (currentRoute != "features") {
          Get.to(
            routeName: "features",
            () => const FeaturesToImpliment(),
            curve: customCurve,
            transition: customTrans,
            duration: duration,
          );
        }
        break;
      case 8: // Settings
        launchUrl(Uri.parse("https://wa.me/+918586047520"));
        break;
    }
  }
}
