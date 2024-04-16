import 'package:flutter/material.dart';

LinearGradient colorsOfGradient() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
    colors: [
      Colors.blue,
      Colors.blueAccent,
    ],
  );
}
