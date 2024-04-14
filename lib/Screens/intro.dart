import 'package:flutter/material.dart';
import 'package:spendwise/Requirements/data.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

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
                left: width * 0.1,
                top: height * 0.15,
              ),
              child: Container(
                width: width * 0.8,
                height: height * 0.25,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.cyan,
                      Colors.lightBlue,
                    ],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(width * 0.05),
                  ),
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
              padding: EdgeInsets.only(left: width * 0.3, top: height * 0.04),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, routes[1]);
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
                  const Icon(
                    Icons.keyboard_double_arrow_right_sharp,
                    color: Colors.blueAccent,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
