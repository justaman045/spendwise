import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:get/get.dart';
import 'package:spendwise/Components/gradient_color.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Screens/home_page.dart';
import 'package:spendwise/Screens/reset_password.dart';
import 'package:spendwise/Screens/signup.dart';

class Login extends StatelessWidget {
  const Login({super.key, required this.bankTransaction});

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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    top: 80.h,
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.r,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    top: 10.h,
                  ),
                  child: Text(
                    "Please Sign in to Continue",
                    style: TextStyle(
                      fontSize: 20.r,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Password",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.off(
                            routeName: routes[2],
                            () => SignUp(
                              bankTransaction: bankTransaction,
                            ),
                            transition: customTrans,
                            curve: customCurve,
                            duration: duration,
                          );
                        },
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                            fontSize: 15.r,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: colorsOfGradient(),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              10.r,
                            ),
                          ),
                        ),
                        width: 80.w,
                        child: TextButton(
                          onPressed: () {
                            Get.to(
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
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.r,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50.h, right: 20.h),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.off(
                          routeName: "saveAndAdd",
                          () => const ResetPassword(),
                          curve: customCurve,
                          transition: customTrans,
                          duration: duration,
                        );
                      },
                      child: Container(
                        width: 150.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.r,
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.blue.shade400,
                              Colors.blue.shade600,
                            ],
                          ),
                        ),
                        child: Center(
                            child: Text(
                          "Reset Password",
                          style: TextStyle(
                            fontSize: 13.r,
                          ),
                        )),
                      ),
                    ),
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
