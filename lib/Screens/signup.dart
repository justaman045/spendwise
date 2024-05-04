import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_sms_inbox/flutter_sms_inbox.dart";
import "package:get/get.dart";
import "package:spendwise/Components/gradient_color.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Screens/home_page.dart";
import "package:spendwise/Screens/login.dart";

class SignUp extends StatelessWidget {
  const SignUp({super.key, required this.bankTransaction});

  final List<SmsMessage> bankTransaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 150.h,
            width: 150.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(150.h),
              ),
              gradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromRGBO(210, 209, 254, 1),
                  Color.fromRGBO(243, 203, 237, 1),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 250.w,
                width: 125.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(200.w),
                    bottomLeft: Radius.circular(200.w),
                  ),
                  gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromRGBO(210, 209, 254, 1),
                      Color.fromRGBO(243, 203, 237, 1),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 550.h, left: 10.w),
            child: Container(
              height: 250.w,
              width: 250.w,
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
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    top: 80.h,
                  ),
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.r,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    top: 5.h,
                  ),
                  child: Text(
                    "Create a Account to keep a track of your money",
                    style: TextStyle(
                      fontSize: 15.r,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    top: 50.h,
                    bottom: 10.h,
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Full Name",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    top: 10.h,
                    bottom: 10.h,
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    top: 10.h,
                    bottom: 10.h,
                  ),
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Password",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    top: 10.h,
                    bottom: 10.h,
                  ),
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Confirm Password",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 60.h,
                    right: 20.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.off(
                            routeName: routes[1],
                            () => Login(
                              bankTransaction: bankTransaction,
                            ),
                            transition: customTrans,
                            curve: customCurve,
                            duration: duration,
                          );
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 13.r,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: colorsOfGradient(),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.w),
                          ),
                        ),
                        width: 150.w,
                        child: TextButton(
                          onPressed: () {
                            Get.offAll(
                              routeName: routes[3],
                              () => HomePage(
                                bankTransaction: bankTransaction,
                              ),
                              transition: customTrans,
                              curve: customCurve,
                              duration: duration,
                            );
                          },
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.r,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
