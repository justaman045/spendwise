class ExpenseType {
  final int id;
  final String name;

  ExpenseType({
    required this.name,
    this.id = 0,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };

  static ExpenseType fromMap(Map<String, dynamic> map) => ExpenseType(
        id: map['id'] as int,
        name: map['name'] as String,
      );
}
