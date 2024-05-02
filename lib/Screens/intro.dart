import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:get/get.dart';
import 'package:spendwise/Components/responsive_methods.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Screens/login.dart';

class Intro extends StatelessWidget {
  const Intro({super.key, required this.bankTransaction});

  final List<SmsMessage> bankTransaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: getScreenWidth(context) / 2 / 2,
                top: getScreenHeight(context) * 0.1,
              ),
              child: SizedBox(
                height: getResponsiveSize(context) * 0.5,
                child: const Image(
                  image: AssetImage("assets/resources/intro.jpg"),
                ),
              ),
            ),
            SizedBox(
              width: getResponsiveSize(context),
              child: Padding(
                padding: EdgeInsets.only(
                  left: getScreenWidth(context) * 0.1,
                  top: getScreenHeight(context) * 0.1,
                ),
                child: Text(
                  "Easy way to Manage your Money",
                  style: TextStyle(
                    fontSize: getScreenHeight(context) * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getScreenWidth(context) * 0.1,
                vertical: getScreenHeight(context) * 0.02,
              ),
              child: Text(
                introText,
                style: TextStyle(
                  fontSize: getScreenHeight(context) * 0.02,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: getScreenHeight(context) * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: TextButton(
                      onPressed: () {
                        Get.to(
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
                        "Get Started",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: getScreenHeight(context) * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_double_arrow_right_sharp,
                    color: Colors.blueAccent,
                    size: getScreenHeight(context) * 0.03,
                  ),
                ],
              ),
            ),
            if (skipSignIn) ...[
              TextButton(
                onPressed: () {},
                child: const Text("Don't want to SignUp??"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getResponsiveWidth(context) * 0.1),
                child: const Text(introSkipLogin),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
