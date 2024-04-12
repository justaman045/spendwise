import 'package:flutter/material.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Screens/home_page.dart';
import 'package:spendwise/Screens/login.dart';

void main() {
  runApp(const SpendWise());
}

class SpendWise extends StatefulWidget {
  const SpendWise({super.key});

  @override
  State<SpendWise> createState() => _SpendWiseState();
}

class _SpendWiseState extends State<SpendWise> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SpendWise",
      debugShowCheckedModeBanner: false,
      initialRoute: homeRoute,
      routes: {
        initialRoute: (context) => const Login(),
        homeRoute: (context) => const HomePage(),
      },
    );
  }
}
