import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Screens/home_page.dart';
import 'package:spendwise/Screens/reset_password.dart';
import 'package:spendwise/Screens/signup.dart';
import 'package:spendwise/Utils/theme.dart';

final _formKey = GlobalKey<FormState>();

// TODO: Reduce Lines of Code
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    // Editing Controller for the Input handleing
    final TextEditingController emailEditingController =
        TextEditingController();
    final TextEditingController passwordEditingController =
        TextEditingController();

    // Render the Login Screen
    return Scaffold(
      body: Stack(
        children: [
          // TO reduce the Widget Transparancy to make the overlapping widget readable
          Opacity(
            opacity: 0.6,

            // Widget for the BackGround Screen Colorfull
            child: Container(
              height: 150.h,
              width: 150.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(150.h),
                ),
                gradient: MyAppColors.avaiableBalanceColor,
              ),
            ),
          ),

          // To display the Colorful widget at the right end of the screen
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // ColorFul Widget
              Container(
                height: 250.w,
                width: 125.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(200.w),
                    bottomLeft: Radius.circular(200.w),
                  ),
                  gradient: MyAppColors.avaiableBalanceColor,
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
                gradient: MyAppColors.avaiableBalanceColor,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
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
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 20.h,
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (!value!.contains("@")) {
                                return "Enter correct email";
                              } else if (RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(emailEditingController.text)) {
                                return null;
                              }
                              return "Please Enter correct Email ID";
                            },
                            controller: emailEditingController,
                            keyboardType: TextInputType.emailAddress,
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
                            validator: (value) {
                              if (value!.length < 8) {
                                return "Password length should be at least 8 Charecters";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            controller: passwordEditingController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: "Password",
                            ),
                          ),
                        ),
                      ],
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
                              () => const SignUp(),
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
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: emailEditingController.text,
                                          password:
                                              passwordEditingController.text);
                                  Get.offAll(
                                    routeName: routes[3],
                                    () => const HomePage(),
                                    transition: customTrans,
                                    curve: customCurve,
                                    duration: duration,
                                  );
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == "invalid-credential") {
                                    Get.snackbar(
                                      "Error",
                                      "Invalid Credentials",
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  } else if (e.code == "too-many-requests") {
                                    Get.snackbar(
                                      "Error",
                                      "Server Error, Try again Later",
                                      snackPosition: SnackPosition.TOP,
                                    );
                                  }
                                }
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Get.isDarkMode
                                    ? MyAppColors
                                        .normalColoredWidgetTextColorDarkMode
                                    : MyAppColors
                                        .normalColoredWidgetTextColorLightMode,
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
                              color: Get.isDarkMode
                                  ? MyAppColors
                                      .normalColoredWidgetTextColorDarkMode
                                  : MyAppColors
                                      .normalColoredWidgetTextColorLightMode,
                            ),
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
