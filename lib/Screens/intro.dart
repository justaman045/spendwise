import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:get/get.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Screens/login.dart';

class Intro extends StatelessWidget {
  const Intro({super.key, required this.bankTransaction});

  final List<SmsMessage> bankTransaction;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.17,
                top: height * 0.08,
              ),
              child: SizedBox(
                height: height * 0.3,
                child: const Image(
                  image: AssetImage("assets/resources/intro.jpg"),
                ),
              ),
            ),
            SizedBox(
              width: width * 0.7,
              child: Padding(
                padding: EdgeInsets.only(
                  left: width * 0.12,
                  top: height * 0.04,
                ),
                child: const Text(
                  "Easy way to Manage your Money",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.13,
                vertical: height * 0.02,
              ),
              child: const Text(
                introText,
                style: TextStyle(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.3,
                top: skipSignIn ? height * 0.01 : height * 0.04,
              ),
              child: Row(
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
                      child: const Text(
                        "Get Started",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_double_arrow_right_sharp,
                    color: Colors.blueAccent,
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
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: const Text(introSkipLogin),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
