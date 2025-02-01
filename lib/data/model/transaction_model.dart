import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

enum TransactionType { income, expense }

@HiveType(typeId: 0)
class TransactionModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final TransactionType type;

  TransactionModel({
    required this.name,
    required this.amount,
    required this.date,
    required this.type,
  });
}
