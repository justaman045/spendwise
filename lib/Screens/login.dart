import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:get/get.dart';
import 'package:spendwise/Components/gradient_color.dart';
import 'package:spendwise/Components/login_ball.dart';
import 'package:spendwise/Components/responsive_methods.dart';
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoginBall(
                  width: getResponsiveSize(context, percent: 0.2),
                  height: getResponsiveSize(context, percent: 0.4),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: getResponsiveHeight(context) * 0.15,
                  ),
                  child: LoginBall(
                    width: getResponsiveSize(context, percent: 0.3),
                    height: getResponsiveSize(context, percent: 0.3),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                left: getResponsiveWidth(context) * 0.1,
                top: getResponsiveHeight(context) * 0.1,
              ),
              child: Text(
                "Login",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: getResponsiveHeight(context) * 0.16,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: getResponsiveWidth(context) * 0.1,
                top: getResponsiveHeight(context) * 0.05,
              ),
              child: Text(
                "Please Sign in to Continue",
                style: TextStyle(fontSize: getResponsiveHeight(context) * 0.1),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getResponsiveWidth(context) * 0.07,
                vertical: getResponsiveHeight(context) * 0.04,
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getResponsiveHeight(context) * 0.07,
                vertical: getResponsiveHeight(context) * 0.01,
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
                left: getResponsiveWidth(context) * 0.6,
                top: getResponsiveHeight(context) * 0.05,
              ),
              child: Row(
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
                    child: const Text("SignUp"),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: colorsOfGradient(),
                      borderRadius: BorderRadius.all(
                        Radius.circular(getResponsiveWidth(context) * 0.035),
                      ),
                    ),
                    width: getResponsiveWidth(context) * 0.2,
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
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: getResponsiveHeight(context) * 0.001),
                          child: LoginBall(
                            width: getResponsiveWidth(context),
                            height: getResponsiveHeight(context),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: getResponsiveWidth(context) * 0.41),
                          child: LoginBall(
                            width: getResponsiveWidth(context),
                            height: getResponsiveHeight(context),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: getResponsiveHeight(context) * 0.03,
                        left: getResponsiveWidth(context) * 0.11,
                      ),
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
                          width: getResponsiveWidth(context) * 0.35,
                          height: getResponsiveHeight(context) * 0.055,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                getResponsiveWidth(context) * 0.04),
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.blue.shade400,
                                Colors.blue.shade600,
                              ],
                            ),
                          ),
                          child: const Center(child: Text("Reset Password")),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
