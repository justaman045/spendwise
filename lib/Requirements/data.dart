import 'package:flutter/material.dart';
import 'package:get/get.dart';

const String userName = "justaman045";
const List<String> routes = [
  "intro",
  "login",
  "signup",
  "",
  "transactions",
  "monthlyTransaction",
  "profile",
  "settings",
  "transaction",
  "cashentry",
  "wallets",
  "editProfile",
  "cashentry",
];
bool loggedin = false;
const int balance = 6123;
const double income = 22600;
const List<String> navBars = [
  "Home",
  "Transactions",
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
const String name = "Aman Ojha";
const String designation = "Software Enginner";
const String emailId = "coderaman07@gmail.com";
const String password = "password";
const List<String> expenseType = ["income", "expense"];
const List<String> typeOfTransaction = [
  "Bike",
  "Travel",
  "Bills",
  "EMI",
  "Entertainment",
  "Food and Drinks",
  "Fuel",
  "Groceries",
  "Health",
  "Investment",
  "Other",
  "Shopping",
  "Transfer",
  "Transfer to Self",
];
