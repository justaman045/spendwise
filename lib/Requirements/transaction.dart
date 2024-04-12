class Transaction {
  final int amount;
  final String dateAndTime;
  final String name;
  final String typeOfTransaction;

  const Transaction({
    required this.amount,
    required this.dateAndTime,
    required this.name,
    required this.typeOfTransaction,
  });
}

final transactions = [
  const Transaction(
    amount: 320,
    dateAndTime: "May 22, 2024, 10:00 AM",
    name: "Harshit Yadav",
    typeOfTransaction: "Friend",
  ),
  const Transaction(
    amount: 5856,
    dateAndTime: "May 22, 2024, 10:00 AM",
    name: "Saloni Gupta",
    typeOfTransaction: "Friend",
  ),
  const Transaction(
    amount: 8256,
    dateAndTime: "May 22, 2024, 10:00 AM",
    name: "Shobhit Nigam",
    typeOfTransaction: "Friend",
  ),
  const Transaction(
    amount: 411,
    dateAndTime: "May 22, 2024, 10:00 AM",
    name: "XBox PC Game Pass",
    typeOfTransaction: "Subscription",
  ),
  const Transaction(
    amount: 3000,
    dateAndTime: "May 22, 2024, 10:00 AM",
    name: "Tinder",
    typeOfTransaction: "Subscription",
  ),
  const Transaction(
    amount: 5000,
    dateAndTime: "May 22, 2024, 10:00 AM",
    name: "Netflix",
    typeOfTransaction: "Subscription",
  ),
];
