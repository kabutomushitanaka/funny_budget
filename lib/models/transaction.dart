enum TransactionType { expense, income }

class Transaction {
  final TransactionType type;
  final int amount;
  final DateTime date;

  Transaction({
    required this.type,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    'type': type.name,
    'amount': amount,
    'date': date.toIso8601String(),
  };

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      type: TransactionType.values.firstWhere((e) => e.name == json['type']),
      amount: json['amount'],
      date: DateTime.parse(json['date']),
    );
  }
}
