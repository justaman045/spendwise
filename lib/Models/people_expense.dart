class PeopleBalance {
  final int id;
  final String name;
  final double amount;
  final String dateAndTime;
  final String
      transactionFor; // What the transaction is for (e.g., Rent, Groceries)
  final String
      relationFrom; // Who the transaction is from/to (e.g., Friend, Roommate)
  final int transactionReferanceNumber;

  PeopleBalance({
    required this.name,
    required this.amount,
    required this.dateAndTime,
    required this.transactionFor,
    required this.relationFrom,
    required this.transactionReferanceNumber,
    this.id = 0,
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'amount': amount,
        'dateAndTime': dateAndTime,
        'transactionFor': transactionFor,
        'relationFrom': relationFrom,
        'transactionReferanceNumber': transactionReferanceNumber,
      };

  static PeopleBalance fromMap(Map<String, dynamic> map) => PeopleBalance(
        id: map['id'] as int,
        name: map['name'] as String,
        amount: map['amount'] as double,
        dateAndTime: map['dateAndTime'] as String,
        transactionFor: map['transactionFor'] as String,
        relationFrom: map['relationFrom'] as String,
        transactionReferanceNumber: map['transactionReferanceNumber'] as int,
      );
}
