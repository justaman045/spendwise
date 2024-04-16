import 'package:flutter/material.dart';
import 'package:spendwise/Components/gradient_color.dart';
import 'package:spendwise/Components/login_ball.dart';
import 'package:spendwise/Requirements/data.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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
                decoration: InputDecoration(
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
                left: width * 0.75,
                top: height * 0.05,
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: colorsOfGradient(),
                  borderRadius: BorderRadius.all(
                    Radius.circular(width * 0.035),
                  ),
                ),
                width: width * 0.2,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, routes[3]);
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
