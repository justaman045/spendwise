import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:spendwise/Components/responsive_methods.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Screens/all_transactions.dart";
import "package:spendwise/Screens/change_password.dart";
import "package:spendwise/Screens/delete_account.dart";
import "package:spendwise/Screens/edit_user_profile.dart";
import "package:spendwise/Screens/intro.dart";

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("Users").get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          dynamic user;
          for (dynamic use in snapshot.data.docs) {
            if (use["email"].toString() ==
                FirebaseAuth.instance.currentUser!.email) {
              user = use;
            }
          }
          // debugPrint(user.toString());
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
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Color.fromRGBO(210, 209, 254, 1),
                                    Color.fromRGBO(243, 203, 237, 1),
                                  ],
                                ),
                              ),
                              width: 120.w,
                              height: 120.h,
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
                                        "Dream of Savings\nRs. ${int.parse(user["dreamToSave"])}",
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
                          type: "expense",
                          pageTitle: "All Payments",
                          chartTitle: "Payments",
                          chartType: "Payments",
                        ),
                        curve: customCurve,
                        transition: customTrans,
                        duration: duration,
                      );
                    },
                    width: getScreenWidth(context),
                    height: getScreenHeight(context),
                    icons: Icon(
                      Icons.wallet_rounded,
                      size: 20.r,
                    ),
                    text: "All Payments",
                  ),
                  MyProfileButtons(
                    fn: () {
                      Get.to(
                        routeName: "Monthly Income",
                        () => const AllTransactions(
                          type: "income",
                          pageTitle: "All Income",
                          chartTitle: "Income",
                          chartType: "Income",
                        ),
                        transition: customTrans,
                        curve: customCurve,
                        duration: duration,
                      );
                    },
                    width: getScreenWidth(context),
                    height: getScreenHeight(context),
                    icons: Icon(
                      Icons.wallet_rounded,
                      size: 20.r,
                    ),
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
                    width: getScreenWidth(context),
                    height: getScreenHeight(context),
                    icons: Icon(
                      Icons.wallet_rounded,
                      size: 20.r,
                    ),
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
          width: getScreenWidth(context),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                icons,
                Text(
                  text,
                  style: TextStyle(fontSize: 13.r),
                ),
                Icon(
                  Icons.chevron_right_sharp,
                  size: 20.r,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
