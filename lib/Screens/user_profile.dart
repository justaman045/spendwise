import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Requirements/transaction.dart";
import "package:spendwise/Screens/all_transactions.dart";
import "package:spendwise/Screens/delete_account.dart";
import "package:spendwise/Screens/edit_user_profile.dart";

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.1,
                top: height * 0.05,
              ),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromRGBO(210, 209, 254, 1),
                              Color.fromRGBO(243, 203, 237, 1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(width * 0.5),
                        ),
                        width: width * 0.35,
                        height: height * 0.16,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.04),
                    child: SizedBox(
                      width: width * 0.45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: TextStyle(fontSize: 24),
                              ),
                              Text(designation),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => Get.to(
                              routeName: routes[11],
                              () => const EditUserProfile(
                                name: name,
                                designation: designation,
                              ),
                              curve: customCurve,
                              transition: customTrans,
                              duration: duration,
                            ),
                            child: const Icon(Icons.edit_outlined),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.075,
                top: height * 0.05,
              ),
              child: const Text("Dashboard"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.07),
              child: const Divider(),
            ),
            MyProfileButtons(
              fn: () {
                Get.to(
                  routeName: routes[4],
                  () => AllTransactions(
                    pageTitle: "All Payments",
                    chartTitle: "Payments",
                    chartType: "Payments",
                    transactioncustom:
                        transactions.where(isExpenseForThisMonth).toList(),
                  ),
                  curve: customCurve,
                  transition: customTrans,
                  duration: duration,
                );
              },
              width: width,
              height: height,
              icons: const Icon(Icons.wallet_rounded),
              text: "All Payments",
            ),
            MyProfileButtons(
              fn: () {
                Get.to(
                  routeName: "Monthly Income",
                  () => AllTransactions(
                    transactioncustom:
                        transactions.where(isIncomeForThisMonth).toList(),
                    pageTitle: "All Income",
                    chartTitle: "Income",
                    chartType: "Income",
                  ),
                  transition: customTrans,
                  curve: customCurve,
                  duration: duration,
                );
              },
              width: width,
              height: height,
              icons: const Icon(Icons.wallet_rounded),
              text: "All Income",
            ),
            MyProfileButtons(
              fn: () {},
              width: width,
              height: height,
              icons: const Icon(Icons.wallet_rounded),
              text: "Change Password",
            ),
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.075,
                top: height * 0.04,
              ),
              child: const Text("Account"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.07),
              child: const Divider(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: TextButton(
                onPressed: () {},
                child: const Text("Sign Out..."),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: TextButton(
                  onPressed: () {
                    Get.to(
                      routeName: "deleteAccount",
                      () => const DeleteAccount(),
                      transition: customTrans,
                      curve: customCurve,
                      duration: duration,
                    );
                  },
                  child: const Text("Delete Account")),
            ),
          ],
        ),
      ),
    );
  }
}

class MyProfileButtons extends StatelessWidget {
  const MyProfileButtons({
    super.key,
    required this.width,
    required this.height,
    required this.icons,
    required this.text,
    required this.fn,
  });

  final double width;
  final double height;
  final Icon icons;
  final String text;
  final Function fn;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => fn(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.07,
          vertical: height * 0.01,
        ),
        child: Container(
          height: height * 0.07,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromRGBO(210, 209, 254, 1),
                Color.fromRGBO(243, 203, 237, 1),
              ],
            ),
            borderRadius: BorderRadius.circular(width * 0.5),
          ),
          width: width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                icons,
                Text(text),
                const Icon(Icons.chevron_right_sharp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
