import "dart:io";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:showcaseview/showcaseview.dart";
import "package:spendwise/Models/db_helper.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Screens/delete_account.dart";
import "package:spendwise/Screens/edit_user_profile.dart";
import "package:spendwise/Screens/intro.dart";
import "package:url_launcher/url_launcher.dart";

// TODO: Reduce Lines of Code
class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  PackageInfo? packageInfo;
  late int totalEntries = 0;
  final GlobalKey _import = GlobalKey();
  final GlobalKey _export = GlobalKey();
  dynamic user;

  @override
  void initState() {
    PackageInfo.fromPlatform().then((value) {
      packageInfo = value;
      setState(() {});
    });
    getTotalEntries();
    super.initState();
    totalEntries.isEqual(0) ? _checkImport() : _checkExport();
    getUserData();
  }

  void getTotalEntries() async {
    totalEntries = await DatabaseHelper().getTotalEntryCount();
    setState(() {});
  }

  Future<void> getUserData() async {
    var currentUserDocument = await FirebaseFirestore.instance
        .collection("Users")
        .where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
    for (dynamic use in currentUserDocument.docs) {
      if (use["email"].toString() == FirebaseAuth.instance.currentUser!.email) {
        setState(() {
          user = use;
        });
      }
    }
  }

  Future<void> _checkImport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTimeImport') ?? true;

    if (isFirstTime) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowCaseWidget.of(context).startShowCase([_import]);
      });

      prefs.setBool('isFirstTimeImport', false);
    }
  }

  Future<void> _checkExport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTimeExport') ?? true;

    if (isFirstTime) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowCaseWidget.of(context).startShowCase([_export]);
      });

      prefs.setBool('isFirstTimeExport', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50.h, left: 20.w),
              child: Text(
                "Settings",
                style: TextStyle(fontSize: 30.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 10.h,
              ),
              child: const Divider(),
            ),
            Expanded(
              child: Column(
                children: [
                  SettingRow(
                    hintMsg: "Edit Profile",
                    icon: Icons.person_outline_rounded,
                    name: "Account",
                    pageFunction: () => Get.to(
                      routeName: routes[11],
                      () => const EditUserProfile(),
                      curve: customCurve,
                      transition: customTrans,
                      duration: duration,
                    ),
                  ),
                  if (totalEntries.isGreaterThan(0)) ...[
                    Showcase(
                      key: _export,
                      description:
                          "You can Export your Transactions if you want to store them as backup",
                      child: SettingRow(
                        icon: Icons.import_export,
                        name: "Export DataBase",
                        hintMsg: "Export DataBase",
                        pageFunction: () => {
                          DatabaseHelper().exportDatabase().then((value) => {
                                if (value.length.isEqual(0))
                                  {
                                    Get.snackbar("Error Encountered",
                                        "Error in Exporting the Database")
                                  }
                                else
                                  {
                                    Get.snackbar("Exported Database",
                                        "Successfully Exported the Database to Location = $value")
                                  }
                              })
                        },
                      ),
                    ),
                  ],
                  if (totalEntries.isEqual(0)) ...[
                    Showcase(
                      key: _import,
                      description:
                          "You can Import your Transactions from the Database file we generated",
                      child: SettingRow(
                        icon: Icons.import_export,
                        name: "Import DataBase",
                        hintMsg: "Import DataBase",
                        pageFunction: () {
                          DatabaseHelper().importDatabase().then(
                            (value) {
                              if (Platform.isAndroid) {
                                SystemNavigator.pop();
                              } else if (Platform.isIOS) {
                                exit(0);
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                  SettingRow(
                    icon: Icons.developer_mode,
                    name: "Enable/Disable Tester Mode",
                    hintMsg: "Testing Options",
                    pageFunction: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      try {
                        bool testerValue;

                        if (user.exists &&
                            user.data()?.containsKey("tester") == true) {
                          // If "tester" field exists, use its current value (or set to true/false based on your logic)
                          testerValue = !(user.data()!["tester"] == true);
                        } else {
                          // If "tester" field doesn't exist, set it to false
                          testerValue = true;
                        }

                        await prefs.setBool('tester', testerValue);

                        await FirebaseFirestore.instance
                            .collection("Users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          "tester": testerValue,
                        }).then((value) {
                          if (testerValue) {
                            Get.snackbar("Testing Mode Enabled",
                                "Congratulations! You are now a Tester for this App");
                            getUserData();
                          } else {
                            Get.snackbar("Testing Mode Disabled",
                                "Sad to see you leave, You're not a Tester for this App anymore");
                            getUserData();
                          }
                        });
                      } catch (e) {
                        debugPrint("Error updating tester field: $e");
                      }
                    },
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text("App Version"),
                      Text("${packageInfo!.version} ( Beta )"),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      launchUrl(Uri.parse("https://justaman045.vercel.app"));
                    },
                    child: const Text("Website"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SettingRow extends StatelessWidget {
  const SettingRow({
    super.key,
    required this.icon,
    required this.name,
    required this.hintMsg,
    required this.pageFunction,
  });

  final IconData icon;
  final String name;
  final String hintMsg;
  final Function pageFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => pageFunction(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 30.r,
                ),
                SizedBox(
                  width: 20.w,
                ),
                SizedBox(
                  width: 160.w,
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 15.r),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 70.w,
                  child: Text(
                    hintMsg,
                    style: TextStyle(fontSize: 12.r),
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 20.r,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
