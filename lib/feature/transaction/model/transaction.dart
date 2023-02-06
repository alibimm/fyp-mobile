import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  final String transactionId;
  final String category;
  final String userId;
  final double amount;
  final TransactionType type;
  final String baseAccount;
  final String? destinationAccount;

  const Transaction({
    this.transactionId = '',
    this.category = '',
    this.userId = '',
    this.amount = 0.0,
    this.type = TransactionType.expense,
    this.baseAccount = '',
    this.destinationAccount
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}

enum TransactionType {
  expense, income, transfer
}