import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:spendwise/Utils/methods.dart";

// TODO: Reduce Lines of Code
class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeModeController>();
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
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dark Mode",
                    style: TextStyle(fontSize: 20.r),
                  ),
                  GestureDetector(
                    onTap: () {
                      themeController.toggleThemeMode();
                      setState(() {});
                    },
                    child: Icon(
                      Get.find<ThemeModeController>().themeMode ==
                              ThemeMode.dark
                          ? Icons.toggle_on
                          : Icons.toggle_off,
                      size: 40.r,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
