import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Screens/login.dart";
import "package:spendwise/Screens/verify_email.dart";
import "package:spendwise/Utils/theme.dart";

final _formKey = GlobalKey<FormState>();

// TODO: Reduce Lines of Code
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController emailEditingController =
  TextEditingController();
  final TextEditingController passwordEditingController =
  TextEditingController();
  final TextEditingController cpasswordEditingController =
  TextEditingController();
  final TextEditingController dreamSavingsController =
  TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  bool _showPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.6,
            child: Container(
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Opacity(
                opacity: 0.6,
                child: Container(
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
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 550.h, left: 10.w),
            child: Opacity(
              opacity: 0.6,
              child: Container(
                height: 250.w,
                width: 250.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: MyAppColors.avaiableBalanceColor,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
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
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            right: 20.w,
                            top: 50.h,
                            bottom: 10.h,
                          ),
                          child: TextFormField(
                            controller: nameEditingController,
                            validator: (value) {
                              if (value!.length < 4) {
                                return "Enter Correct Name";
                              } else if (value.length > 20) {
                                return "Name can only be at-least 20 characters";
                              }
                              return null;
                            },
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
                            controller: emailEditingController,
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
                            controller: passwordEditingController,
                            validator: (value) {
                              if (value!.length < 8) {
                                return "Password length should be at least 8 Characters";
                              }
                              return null;
                            },
                            obscureText: _showPassword,
                            decoration: InputDecoration(
                              hintText: "Password",
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _showPassword = !_showPassword;
                                  setState(() {});
                                },
                                child: Icon(
                                  _showPassword
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility_rounded,
                                ),
                              ),
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
                            controller: cpasswordEditingController,
                            validator: (value) {
                              if (value!.length < 8) {
                                return "Password length should be at least 8 Charecters";
                              }
                              if (value != passwordEditingController.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                            obscureText: _showPassword,
                            decoration: InputDecoration(
                              hintText: "Confirm Password",
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _showPassword = !_showPassword;
                                  setState(() {});
                                },
                                child: Icon(
                                  _showPassword
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility_rounded,
                                ),
                              ),
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
                            controller: userNameController,
                            decoration: const InputDecoration(
                              hintText: "Username (optional)",
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
                            keyboardType: TextInputType.number,
                            controller: dreamSavingsController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "You have to give a Amount between 50 - 1,00,00,000";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: "Monthly Salary",
                            ),
                          ),
                        ),
                      ],
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
                              () => const Login(),
                              transition: customTrans,
                              curve: customCurve,
                              duration: duration,
                            );
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 13.r,
                              color: Get.isDarkMode
                                  ? MyAppColors
                                      .normalColoredWidgetTextColorDarkMode
                                  : MyAppColors
                                      .normalColoredWidgetTextColorDarkMode,
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
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: emailEditingController.text,
                                          password:
                                              passwordEditingController.text)
                                      .then(
                                    (value) async {
                                      await value.user?.updateDisplayName(
                                          nameEditingController.text);
                                      await FirebaseFirestore.instance
                                          .collection("Users")
                                          .doc(value.user!.uid)
                                          .set({
                                        "email": value.user!.email,
                                        "name": nameEditingController.text,
                                        "username": userNameController
                                                .text.isEmpty
                                            ? value.user!.email!.split("@")[0]
                                            : userNameController.text,
                                        "dreamToSave":
                                            dreamSavingsController.text,
                                        "dateOfJoining": DateTime.now(),
                                      }).then(
                                        (value) => Get.offAll(
                                          routeName: routes[15],
                                          () => const VerifyEmail(),
                                          transition: customTrans,
                                          curve: customCurve,
                                          duration: duration,
                                        ),
                                      );
                                    },
                                  );
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == "email-already-in-use") {
                                    Get.snackbar(
                                      "Error",
                                      "Email already being used by some user, Try resetting the password.",
                                      snackPosition: SnackPosition.TOP,
                                    );
                                  } else {}
                                }
                              }
                            },
                            child: Text(
                              "Create Account",
                              style: TextStyle(
                                color: Get.isDarkMode
                                    ? MyAppColors
                                        .normalColoredWidgetTextColorDarkMode
                                    : MyAppColors
                                        .normalColoredWidgetTextColorLightMode,
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
          ),
        ],
      ),
    );
  }
}
