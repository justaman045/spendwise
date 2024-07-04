import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Screens/edit_user_profile.dart";

// TODO: Reduce Lines of Code
class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: TextButton(
                onPressed: () {
                  Get.to(
                    routeName: routes[11],
                    () => const EditUserProfile(),
                    curve: customCurve,
                    transition: customTrans,
                    duration: duration,
                  );
                },
                child: Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 15.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
