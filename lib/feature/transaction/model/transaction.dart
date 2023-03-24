import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
@HiveType(typeId: 1, adapterName: 'TransactionAdapter')
class Transaction {
  @HiveField(1, defaultValue: '')
  final String transactionId;
  @HiveField(2, defaultValue: '')
  final String category;
  @HiveField(3, defaultValue: '')
  final String userId;
  @HiveField(4, defaultValue: 0.0)
  final double amount;
  @HiveField(5, defaultValue: TransactionType.expense)
  final TransactionType type;
  @HiveField(6, defaultValue: '')
  final String baseAccount;
  @HiveField(7, defaultValue: '')
  final String? destinationAccount;
  @HiveField(11)
  final DateTime? date;

  const Transaction({
    this.transactionId = '',
    this.category = '',
    this.userId = '',
    this.amount = 0.0,
    this.type = TransactionType.expense,
    this.baseAccount = '',
    this.destinationAccount,
    this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}

@HiveType(typeId: 2, adapterName: 'TransactionTypeAdapter')
enum TransactionType {
  @HiveField(8)
  expense,
  @HiveField(9)
  income,
  @HiveField(10)
  transfer
}
