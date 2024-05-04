import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

class Settings extends StatelessWidget {
  const Settings({super.key});

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
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dark Mode",
                    style: TextStyle(fontSize: 20.r),
                  ),
                  Icon(
                    Icons.toggle_off,
                    size: 40.r,
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
