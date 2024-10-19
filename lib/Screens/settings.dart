import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:package_info_plus/package_info_plus.dart";
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

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((value) {
      packageInfo = value;
      setState(() {});
    });
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
            ],),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text("App Version"),
                      Text(packageInfo!.version),
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
                Text(
                  name,
                  style: TextStyle(fontSize: 15.r),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  hintMsg,
                  style: TextStyle(fontSize: 12.r),
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
