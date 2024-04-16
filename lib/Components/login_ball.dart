import 'package:flutter/material.dart';
import 'package:spendwise/Components/gradient_color.dart';

class LoginBall extends StatelessWidget {
  const LoginBall({
    super.key,
    required this.width,
    required this.height,
    required this.widthOfBall,
    required this.heightOfBall,
    required this.radiusOfBall,
  });

  final double width;
  final double height;
  final double widthOfBall;
  final double heightOfBall;
  final double radiusOfBall;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: colorsOfGradient(),
        borderRadius: BorderRadius.all(
          Radius.circular(width * radiusOfBall),
        ),
      ),
      width: width * widthOfBall,
      height: height * heightOfBall,
    );
  }
}
