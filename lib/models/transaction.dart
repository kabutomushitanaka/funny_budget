enum TransactionType {
  income,
  expense,
}

class Transaction {
  final TransactionType type;
  final int amount;
  final DateTime date;

  Transaction({
    required this.type,
    required this.amount,
    required this.date,
  });

  // JSON形式に変換
  Map<String, dynamic> toJson() => {
    'type': type.name, // enum → 文字列に変換
    'amount': amount,
    'date': date.toIso8601String(),
  };

  // JSONから生成
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      type: TransactionType.values.byName(json['type']), // 文字列 → enum
      amount: json['amount'],
      date: DateTime.parse(json['date']),
    );
  }
}
