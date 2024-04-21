import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:google_nav_bar/google_nav_bar.dart";
import 'package:line_icons/line_icons.dart';
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Requirements/transaction.dart";
import "package:spendwise/Screens/all_transactions.dart";
import "package:spendwise/Screens/user_profile.dart";

// have to install this dependeancy
// google_nav_bar: ^5.0.6

class GoogleNavBarBottom extends StatefulWidget {
  const GoogleNavBarBottom({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  State<GoogleNavBarBottom> createState() => _GoogleNavBarBottomState();
}

class _GoogleNavBarBottomState extends State<GoogleNavBarBottom> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget.width * 0.08),
            topRight: Radius.circular(widget.width * 0.08),
          ),
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
          ]),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widget.height * 0.03,
            vertical: widget.height * 0.018,
          ),
          child: GNav(
            gap: 8,
            activeColor: Colors.white,
            iconSize: 24,
            padding: EdgeInsets.symmetric(
                horizontal: widget.width * 0.025,
                vertical: widget.height * 0.01),
            duration: const Duration(milliseconds: 800),
            tabBackgroundColor: Colors.grey.shade500,
            tabs: [
              GButton(
                onPressed: () {},
                icon: LineIcons.home,
                text: navBars[0],
              ),
              GButton(
                onPressed: () {
                  if (ModalRoute.of(context)?.settings.name != routes[4]) {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const Login()));
                    Get.to(
                      routeName: routes[4],
                      () => AllTransactions(
                        pageTitle: "All Transactions",
                        chartTitle: "All Transactions from SMS",
                        chartType: "Transaction",
                        transactioncustom: transactions,
                      ),
                      transition: customTrans,
                      curve: customCurve,
                      duration: duration,
                    );
                  }
                },
                icon: Icons.payment_rounded,
                text: navBars[1],
              ),
              GButton(
                icon: LineIcons.user,
                text: navBars[2],
                onPressed: () {
                  if (ModalRoute.of(context)?.settings.name != routes[6]) {
                    Get.to(
                      routeName: routes[6],
                      () => const UserProfile(),
                      transition: customTrans,
                      curve: customCurve,
                      duration: duration,
                    );
                  }
                },
              ),
              GButton(
                icon: Icons.settings,
                text: navBars[3],
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(
                () {
                  _selectedIndex = index;
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
