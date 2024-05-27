import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:spendwise/Utils/theme.dart";

final _formKey = GlobalKey<FormState>();

// TODO: Reduce Lines of Code
class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController newPasswordEditingController =
        TextEditingController();
    TextEditingController cnewPasswordEditingController =
        TextEditingController();
    TextEditingController oldPasswordEditingController =
        TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 150.h,
                width: 150.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(
                      200.r,
                    ),
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
                    height: 180.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(200.r),
                        bottomLeft: Radius.circular(200.r),
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
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 100.h,
                        left: 20.w,
                      ),
                      child: Text(
                        "Change Password",
                        style: TextStyle(
                          fontSize: 30.r,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.w,
                        right: 20.w,
                        top: 10.h,
                      ),
                      child: Text(
                        "You're just one step away from changing your Password",
                        style: TextStyle(fontSize: 15.r),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    top: 10.h,
                  ),
                  child: TextFormField(
                    controller: oldPasswordEditingController,
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
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    top: 10.h,
                  ),
                  child: TextFormField(
                    controller: newPasswordEditingController,
                    validator: (value) {
                      if (value!.length < 8) {
                        return "Password should be atleast 8 Charcters";
                      } else if (value == oldPasswordEditingController.text) {
                        return "Old Password matches with the new Password";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: Text(
                        "New Password",
                        style: TextStyle(fontSize: 15.r),
                      ),
                      prefixIcon: Icon(
                        Icons.password,
                        size: 15.r,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.length < 8) {
                        return "Password should be atleast 8 Charcters";
                      } else if (cnewPasswordEditingController.text !=
                          oldPasswordEditingController.text) {
                        return "New Passwords do not match";
                      }
                      return null;
                    },
                    controller: cnewPasswordEditingController,
                    decoration: InputDecoration(
                      label: Text(
                        "Confirm New Password",
                        style: TextStyle(fontSize: 15.r),
                      ),
                      prefixIcon: Icon(
                        Icons.password,
                        size: 15.r,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 70.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 130.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(250.r),
                          bottomLeft: Radius.circular(250.r),
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
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromRGBO(210, 209, 254, 1),
                              Color.fromRGBO(243, 203, 237, 1),
                            ],
                          ),
                        ),
                        width: 100.w,
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
                                      .normalColoredWidgetTextColorDarkMode,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        // FirebaseAuth.instance.
                        final user = FirebaseAuth.instance.currentUser;
                        final credential = EmailAuthProvider.credential(
                            email: user!.email.toString(),
                            password: oldPasswordEditingController.text);
                        try {
                          await user.reauthenticateWithCredential(credential);
                          await user
                              .updatePassword(newPasswordEditingController.text)
                              .then((value) => Get.back());
                        } on FirebaseAuthException catch (e) {
                          debugPrint(e.code);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromRGBO(210, 209, 254, 1),
                              Color.fromRGBO(243, 203, 237, 1),
                            ],
                          ),
                        ),
                        width: 100.w,
                        height: 50.h,
                        child: Center(
                          child: Text(
                            "Save Changes",
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
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
