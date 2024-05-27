import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Screens/intro.dart';
import 'package:spendwise/Utils/theme.dart';

final _formKey = GlobalKey<FormState>();

// TODO: Reduce Lines of Code
class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordEditingController = TextEditingController();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.red.shade400,
              Colors.red.shade600,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 100.h,
                  left: 30.w,
                ),
                child: Text(
                  "Delete Account",
                  style: TextStyle(
                    fontSize: 35.r,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 30.h,
                  horizontal: 30.w,
                ),
                child: Text(
                  "We're very sorry to see you go away from us. Are you sure you want to go away from us and this Time saving appp??. If not you can just right away click the go back button and, no harm will come to your account.",
                  style: TextStyle(
                    height: 1.5.r,
                    fontSize: 15.r,
                  ),
                ),
              ),
              Form(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    top: 10.h,
                  ),
                  child: TextFormField(
                    controller: passwordEditingController,
                    validator: (value) {
                      if (value!.length < 8) {
                        return "Password should be atleast 8 Charcters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: Text(
                        "Old Password",
                        style: TextStyle(fontSize: 15.r),
                      ),
                      prefixIcon: Icon(
                        Icons.password,
                        size: 15.r,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 100.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            30.w,
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
                        width: 150.w,
                        height: 50.h,
                        child: Center(
                          child: Text(
                            "Go Back",
                            style: TextStyle(
                              fontSize: 13.r,
                              color: Get.isDarkMode
                                  ? MyAppColors
                                      .normalColoredWidgetTextColorDarkMode
                                  : MyAppColors
                                      .normalColoredWidgetTextColorLightMode,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          final user = FirebaseAuth.instance.currentUser;
                          final credential = EmailAuthProvider.credential(
                              email: user!.email.toString(),
                              password: passwordEditingController.text);
                          await user.reauthenticateWithCredential(credential);
                          await FirebaseAuth.instance.currentUser!
                              .delete()
                              .then((value) => Get.offAll(
                                    routeName: routes[3],
                                    () => const Intro(),
                                    transition: customTrans,
                                    curve: customCurve,
                                    duration: duration,
                                  ));
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            30.w,
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
                        width: 150.w,
                        height: 50.h,
                        child: Center(
                          child: Text(
                            "Delete Account",
                            style: TextStyle(
                              fontSize: 13.r,
                              color: Get.isDarkMode
                                  ? MyAppColors
                                      .normalColoredWidgetTextColorDarkMode
                                  : MyAppColors
                                      .normalColoredWidgetTextColorLightMode,
                            ),
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
    );
  }
}
