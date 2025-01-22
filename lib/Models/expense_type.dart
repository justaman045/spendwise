class ExpenseType {
  final int id;
  final String name;
  final double amount;

  ExpenseType({
    required this.name,
    required this.amount,
    this.id = 0,
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'amount': amount,
  };

  // Corrected fromMap method
  static ExpenseType fromMap(Map<String, dynamic> map) => ExpenseType(
    id: map['id'] as int,
    name: map['name'] as String,
    amount: map['amount'] as double,
  );
}