import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:get/get.dart';
import 'package:spendwise/Components/gradient_color.dart';
import 'package:spendwise/Components/login_ball.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Screens/home_page.dart';
import 'package:spendwise/Screens/reset_password.dart';
import 'package:spendwise/Screens/signup.dart';

class Login extends StatelessWidget {
  const Login({super.key, required this.bankTransaction});

  final List<SmsMessage> bankTransaction;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: width * 0.5),
                  child: LoginBall(
                      width: width,
                      height: height,
                      widthOfBall: 0.1,
                      heightOfBall: 0.05,
                      radiusOfBall: 0.2),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.04),
                  child: LoginBall(
                    width: width,
                    height: height,
                    widthOfBall: 0.4,
                    heightOfBall: 0.2,
                    radiusOfBall: 0.2,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.09, top: height * 0.04),
              child: const Text(
                "Login",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.09, top: height * 0.01),
              child: const Text(
                "Please Sign in to Continue",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.07,
                vertical: height * 0.04,
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.07,
                vertical: height * 0.01,
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
                left: width * 0.6,
                top: height * 0.05,
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
                        Radius.circular(width * 0.035),
                      ),
                    ),
                    width: width * 0.2,
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
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.04),
                      child: LoginBall(
                        width: width,
                        height: height,
                        widthOfBall: 0.4,
                        heightOfBall: 0.2,
                        radiusOfBall: 0.2,
                      ),
                    ),
                    LoginBall(
                      width: width,
                      height: height,
                      widthOfBall: 0.1,
                      heightOfBall: 0.05,
                      radiusOfBall: 0.2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.03,
                        left: width * 0.11,
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
                          width: width * 0.35,
                          height: height * 0.055,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width * 0.04),
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
