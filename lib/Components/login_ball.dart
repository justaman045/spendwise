import 'package:flutter/material.dart';
import 'package:spendwise/Components/gradient_color.dart';

// TODO: Reduce Lines of Code
class LoginBall extends StatelessWidget {
  const LoginBall({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: colorsOfGradient(),
        shape: BoxShape.circle,
      ),
    );
  }
}
