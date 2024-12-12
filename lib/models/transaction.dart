class Transaction {
  final int id;
  final double amount;

  Transaction({required this.id, required this.amount});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      amount: json['amount']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'amount': amount,
  };
}
