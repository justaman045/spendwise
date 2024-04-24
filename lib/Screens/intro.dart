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
                left: getResponsiveWidth(context) * 0.3,
                top: getResponsiveHeight(context) * 0.3,
              ),
              child: SizedBox(
                height: getResponsiveHeight(context) * 1.1,
                child: const Image(
                  image: AssetImage("assets/resources/intro.jpg"),
                ),
              ),
            ),
            SizedBox(
              width: getResponsiveWidth(context) + 10,
              child: Padding(
                padding: EdgeInsets.only(
                  left: getResponsiveHeight(context) * 0.12,
                  top: getResponsiveHeight(context) * 0.2,
                ),
                child: Text(
                  "Easy way to Manage your Money",
                  style: TextStyle(
                    fontSize: getResponsiveWidth(context) * 0.1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getResponsiveHeight(context) * 0.13,
                vertical: getResponsiveHeight(context) * 0.1,
              ),
              child: Text(
                introText,
                style: TextStyle(
                  fontSize: getResponsiveHeight(context) * 0.08,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: getResponsiveWidth(context) * 0.3,
                top: skipSignIn
                    ? getResponsiveHeight(context) * 0.01
                    : getResponsiveHeight(context) * 0.1,
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
