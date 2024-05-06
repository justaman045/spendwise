import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendwise/Components/responsive_methods.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Screens/login.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 70.h,
                  ),
                  child: SizedBox(
                    height: 200.r,
                    child: const Image(
                      image: AssetImage("assets/resources/intro.jpg"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 330.w,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 35.w,
                  top: 50.h,
                ),
                child: Text(
                  "Easy way to Manage your Money",
                  style: TextStyle(
                    fontSize: 30.r,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 33.w,
                vertical: 14.h,
              ),
              child: Text(
                introText,
                style: TextStyle(
                  fontSize: 17.r,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: TextButton(
                      onPressed: () {
                        Get.to(
                          routeName: routes[1],
                          () => const Login(),
                          transition: customTrans,
                          curve: customCurve,
                          duration: duration,
                        );
                      },
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: getScreenHeight(context) * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_double_arrow_right_sharp,
                    color: Colors.blueAccent,
                    size: getScreenHeight(context) * 0.03,
                  ),
                ],
              ),
            ),
            if (skipSignIn) ...[
              TextButton(
                onPressed: () {},
                child: const Text("Don't want to SignUp??"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getResponsiveWidth(context) * 0.1),
                child: const Text(introSkipLogin),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
