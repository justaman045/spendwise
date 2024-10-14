import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Screens/login.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    // Return the Into Page for the App if not Signed In
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the Image of the Intro Page
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

            // Give a Headline of the App and the Moto for developing the App
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

            // A Text Intro for the App
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

            // A button to move on forward in the App
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
                          fontSize: 25.r,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_double_arrow_right_sharp,
                    color: Colors.blueAccent,
                    size: 25.r,
                  ),
                ],
              ),
            ),

            //TODO: Also keep for no Account usage
            if (skipSignIn) ...[
              SizedBox(
                width: 400.w,
                height: 70.h,
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text("Don't want to SignUp??"),
                    ),
                    const Text(introSkipLogin),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
