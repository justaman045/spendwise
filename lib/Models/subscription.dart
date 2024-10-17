class Subscription {
  final int id;
  final String fromDate;
  final String toDate;
  final String isRecurring;
  final double amount;
  final String name;
  final String tenure;

  Subscription({
    required this.fromDate,
    required this.toDate,
    required this.amount,
    required this.name,
    required this.isRecurring,
    required this.tenure,
    this.id = 0,
  });

  Map<String, dynamic> toMap() => {
        'fromDate': fromDate,
        'toDate': toDate,
        'amount': amount,
        'name': name,
        'isRecurring': isRecurring,
        'tenure': tenure,
      };

  static Subscription fromMap(Map<String, dynamic> map) => Subscription(
        id: map['id'] as int,
        fromDate: map['fromDate'] as String,
        toDate: map['toDate'] as String,
        amount: map['amount'] as double,
        name: map['name'] as String,
    isRecurring: map['isRecurring'] as String,
    tenure: map['tenure'] as String,
      );
}
