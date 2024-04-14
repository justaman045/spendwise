import 'package:flutter/material.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Screens/home_page.dart';
import 'package:spendwise/Screens/intro.dart';
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
      routes: {
        routes[0]: (context) => const Intro(),
        routes[1]: (context) => const Login(),
        routes[3]: (context) => const HomePage(),
      },
      home: loggedin ? const HomePage() : const Intro(),
    );
  }
}
