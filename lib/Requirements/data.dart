import 'package:flutter/material.dart';
import 'package:get/get.dart';

// // TODO: Reduce Lines of Code
const String tableName = 'transactions';
const String subscriptionsTable = 'subscriptions';
const String peopleBalanceTable = 'peopleBalance';
const String expenseTypesTable = 'expenseTypes';
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
  "subscription",
  "add_subscription"
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
const List<String> typeOfTransaction = ["income", "expense", "didn't Pay"];
const List<String> typeOfExpense = [
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
// const String openingQuery =
//     "CREATE TABLE IF NOT EXISTS cus_transaction (amount REAL NOT NULL,  date_and_time TEXT NOT NULL,  name TEXT NOT NULL,  type_of_transaction TEXT NOT NULL,  expense_type TEXT,  transaction_reference_number INTEGER PRIMARY KEY);";
const String appName = "SpendWise";
