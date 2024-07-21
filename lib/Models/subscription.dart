class Subscription {
  final int id;
  final String fromDate;
  final String toDate;
  final String recurringDate;
  final double amount;
  final String name;

  Subscription({
    required this.fromDate,
    required this.toDate,
    required this.amount,
    required this.name,
    required this.recurringDate,
    this.id = 0,
  });

  Map<String, dynamic> toMap() => {
        'fromDate': fromDate,
        'toDate': toDate,
        'amount': amount,
        'name': name,
        'recurringDate': recurringDate,
      };

  static Subscription fromMap(Map<String, dynamic> map) => Subscription(
        id: map['id'] as int,
        fromDate: map['fromDate'] as String,
        toDate: map['toDate'] as String,
        amount: map['amount'] as double,
        name: map['name'] as String,
        recurringDate: map['recurringDate'] as String,
      );
}
