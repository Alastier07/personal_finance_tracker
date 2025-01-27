enum TransactionType { income, expense }

class TransactionModel {
  final String name;
  final double amount;
  final DateTime date;
  final TransactionType type;

  TransactionModel({
    required this.name,
    required this.amount,
    required this.date,
    required this.type,
  });
}
