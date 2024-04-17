import 'package:flutter/material.dart';
import 'package:get/get.dart';

const String userName = "justaman045";
const List<String> routes = [
  "intro",
  "login",
  "signup",
  "home",
  "transactions",
  "monthlyTransaction",
  "profile",
  "settings",
  "transaction",
  "cashentry",
  "wallets",
];
bool loggedin = true;
const int balance = 6123;
const double income = 22600;
const List<String> navBars = [
  "Home",
  "Login",
  "User Profile",
  "Settings",
];
const String introText =
    "Experience the future of Payments with our user-friendly app. Say goodbye to Notes making and other unusefull process of recording your transactions.";
const String introSkipLogin =
    "Use app without Login/Signup for Free forever. But we insist you to do so as it help us to know oour potential Customers";
const bool skipSignIn = false;
const int animationDuration = 2;
const Transition customTrans = Transition.circularReveal;
const Curve customCurve = Curves.bounceInOut;
const Duration duration = Duration(seconds: 1);
