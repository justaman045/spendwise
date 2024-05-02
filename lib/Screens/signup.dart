import "package:flutter/material.dart";
import "package:flutter_sms_inbox/flutter_sms_inbox.dart";
import "package:get/get.dart";
import "package:spendwise/Components/gradient_color.dart";
import "package:spendwise/Components/login_ball.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Screens/home_page.dart";
import "package:spendwise/Screens/login.dart";

class SignUp extends StatelessWidget {
  const SignUp({super.key, required this.bankTransaction});

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
                  padding: EdgeInsets.only(left: width * 0.65),
                  child: LoginBall(
                    width: width,
                    height: height,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.04),
                  child: LoginBall(
                    width: width,
                    height: height,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.09, top: height * 0.03),
              child: const Text(
                "Create Account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.09, top: height * 0.005),
              child: const Text(
                "Create a Account to keep a track of your money",
                style: TextStyle(fontSize: 17),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.1,
                right: width * 0.1,
                top: height * 0.01,
                bottom: height * 0.01,
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Full Name",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.1,
                right: width * 0.1,
                top: height * 0.01,
                bottom: height * 0.01,
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.1,
                right: width * 0.1,
                top: height * 0.01,
                bottom: height * 0.01,
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
                left: width * 0.1,
                right: width * 0.1,
                top: height * 0.01,
                bottom: height * 0.01,
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
                left: width * 0.35,
                top: height * 0.025,
              ),
              child: Row(
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
                    child: const Text("Login"),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: colorsOfGradient(),
                      borderRadius: BorderRadius.all(
                        Radius.circular(width * 0.035),
                      ),
                    ),
                    width: width * 0.4,
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
                      child: const Text(
                        "Create Account",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: height * 0.02),
                  child: LoginBall(
                    width: width,
                    height: height,
                  ),
                ),
                LoginBall(
                  width: width,
                  height: height,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
