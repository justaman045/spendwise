import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:spendwise/Components/gradient_color.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Screens/home_page.dart";
import "package:spendwise/Screens/login.dart";

final _formKey = GlobalKey<FormState>();

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameEditingController = TextEditingController();
    final TextEditingController emailEditingController =
        TextEditingController();
    final TextEditingController passwordEditingController =
        TextEditingController();
    final TextEditingController cpasswordEditingController =
        TextEditingController();
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
                              return "Name can only be atleast 20 charecters";
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
                              return "Password length should be at least 8 Charecters";
                            }
                            return null;
                          },
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
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: "Confirm Password",
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
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: emailEditingController.text,
                                      password: passwordEditingController.text);
                              Get.offAll(
                                routeName: routes[3],
                                () => const HomePage(),
                                transition: customTrans,
                                curve: customCurve,
                                duration: duration,
                              );
                            }
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
