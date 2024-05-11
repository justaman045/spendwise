import 'package:spendwise/Models/account.dart';
import 'package:spendwise/Models/cus_transaction.dart';

final transactionss = [
  // Existing transactions with "expenseType" added
  CusTransaction(
    amount: 22600,
    dateAndTime: DateTime(2024, 5, 1, 7, 00),
    name: "Salary",
    typeOfTransaction: "Salary",
    expenseType: "income",
    transactionReferanceNumber: 548354912476,
  ),
  CusTransaction(
    amount: 5000,
    dateAndTime: DateTime(2024, 5, 3, 7, 00),
    name: "Credit Card Payment of ICIC Mine Credit Card",
    typeOfTransaction: "EMI",
    expenseType: "expense",
    transactionReferanceNumber: 548354912476,
  ),
  CusTransaction(
    amount: 5000,
    dateAndTime: DateTime(2024, 4, 3, 7, 00),
    name: "Credit Card Payment of ICIC Mine Credit Card",
    typeOfTransaction: "EMI",
    expenseType: "expense",
    transactionReferanceNumber: 548354912476,
  ),
];

final accounts = [
  Account(
    accountNumber: 858647520,
    bankName: "PayTM Account",
    bankUserName: "Aman Ojha",
  ),
];
