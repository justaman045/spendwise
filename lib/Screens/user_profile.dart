import "dart:math";

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:spendwise/Models/cus_transaction.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Requirements/transaction.dart";
import "package:spendwise/Screens/all_transactions.dart";
import "package:spendwise/Screens/change_password.dart";
import "package:spendwise/Screens/delete_account.dart";
import "package:spendwise/Screens/edit_user_profile.dart";
import "package:spendwise/Screens/intro.dart";
import "package:spendwise/Utils/methods.dart";
import "package:spendwise/Utils/theme.dart";

// TODO: Reduce Lines of Code
class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // Local Variable Declaration to use it in rendering
  List<CusTransaction> bankTransaction = [];
  // ignore: unused_field
  Future? _future;
  dynamic _user;
  dynamic username;

  // // Function to run everytime a user expects to refresh the data but the value is not being used
  // Future<void> _refreshData() async {
  //   setState(() {
  //     _future = getTransactions();
  //   });
  // }

  // Get the User from the Server and update the Current User only if the User Data have been recived
  Future<void> _getData() async {
    dynamic getUserData = await getUser();
    if (_user == null) {
      setState(() {
        _user = getUserData;
      });
    }
  }

  // Override default method to get the initial data beforehand only
  @override
  void initState() {
    // _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<CusTransaction> bankTransaction = [];
    _getData();
    return FutureBuilder(
      future: getTransactions(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if ((snapshot.connectionState == ConnectionState.done) &&
            (_user != null)) {
          dynamic user;
          for (dynamic use in _user.docs) {
            if (use["email"].toString() ==
                FirebaseAuth.instance.currentUser!.email) {
              user = use;
            }
          }
          bankTransaction = allTransactions(snapshot.data);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "My Profile",
                style: TextStyle(fontSize: 20.r),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 30.w,
                      top: 35.h,
                    ),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: MyAppColors.avaiableBalanceColor,
                              ),
                              width: 120.w,
                              height: 120.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 15.w, top: 2.5.h),
                              child: Image(image: const AssetImage("assets/pfp/4.png"),height: 110.h,),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15.w),
                          child: SizedBox(
                            width: 170.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 150.w,
                                      child: Text(
                                        user["name"],
                                        style: TextStyle(fontSize: 25.r),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150.w,
                                      child: Text(
                                        "Rs. ${totalAvailableBalance(bankTransaction)} more to Save",
                                        style: TextStyle(fontSize: 13.r),
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () => Get.to(
                                    routeName: routes[11],
                                    () => const EditUserProfile(),
                                    curve: customCurve,
                                    transition: customTrans,
                                    duration: duration,
                                  ),
                                  child: Icon(
                                    Icons.edit_outlined,
                                    size: 20.r,
                                  ),
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
                      left: 30.w,
                      top: 30.h,
                    ),
                    child: Text(
                      "Dashboard",
                      style: TextStyle(
                        fontSize: 15.r,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: const Divider(),
                  ),
                  MyProfileButtons(
                    fn: () {
                      Get.to(
                        routeName: routes[4],
                        () => const AllTransactions(
                          type: "withhiddenexpense",
                          pageTitle: "All Payments",
                          chartTitle: "Payments",
                          chartType: "Payments",
                        ),
                        curve: customCurve,
                        transition: customTrans,
                        duration: duration,
                      );
                    },
                    icons: Icons.wallet_rounded,
                    text: "All Payments",
                  ),
                  MyProfileButtons(
                    fn: () {
                      Get.to(
                        routeName: "Monthly Income",
                        () => const AllTransactions(
                          type: "withhiddenincome",
                          pageTitle: "All Income",
                          chartTitle: "Income",
                          chartType: "Income",
                        ),
                        transition: customTrans,
                        curve: customCurve,
                        duration: duration,
                      );
                    },
                    icons: Icons.wallet_rounded,
                    text: "All Income",
                  ),
                  MyProfileButtons(
                    fn: () {
                      Get.to(
                        routeName: "changePassword",
                        () => const ChangePassword(),
                        transition: customTrans,
                        curve: customCurve,
                        duration: duration,
                      );
                    },
                    icons: Icons.wallet_rounded,
                    text: "Change Password",
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 30.w,
                      top: 30.h,
                    ),
                    child: Text(
                      "Account",
                      style: TextStyle(fontSize: 13.r),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                    ),
                    child: const Divider(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    child: TextButton(
                      onPressed: () async {
                        await FirebaseAuth.instance
                            .signOut()
                            .then((value) => Get.offAll(
                                  routeName: routes[3],
                                  () => const Intro(),
                                  transition: customTrans,
                                  curve: customCurve,
                                  duration: duration,
                                ));
                      },
                      child: Text(
                        "Sign Out...",
                        style: TextStyle(fontSize: 15.r),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
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
                        child: Text(
                          "Delete Account",
                          style: TextStyle(fontSize: 15.r),
                        )),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: SafeArea(
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }
      },
    );
  }
}

class MyProfileButtons extends StatelessWidget {
  const MyProfileButtons({
    super.key,
    required this.icons,
    required this.text,
    required this.fn,
  });

  final IconData icons;
  final String text;
  final Function fn;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => fn(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 25.w,
          vertical: 5.h,
        ),
        child: Container(
          height: 50.h,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromRGBO(210, 209, 254, 1),
                Color.fromRGBO(243, 203, 237, 1),
              ],
            ),
            borderRadius: BorderRadius.circular(50.w),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icons,
                  color: Get.isDarkMode
                      ? MyAppColors.normalColoredWidgetTextColorDarkMode
                      : MyAppColors.normalColoredWidgetTextColorDarkMode,
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 13.r,
                    color: Get.isDarkMode
                        ? MyAppColors.normalColoredWidgetTextColorDarkMode
                        : MyAppColors.normalColoredWidgetTextColorDarkMode,
                  ),
                ),
                Icon(
                  Icons.chevron_right_sharp,
                  size: 20.r,
                  color: Get.isDarkMode
                      ? MyAppColors.normalColoredWidgetTextColorDarkMode
                      : MyAppColors.normalColoredWidgetTextColorDarkMode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
