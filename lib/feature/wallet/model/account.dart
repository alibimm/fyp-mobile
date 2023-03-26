import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
@HiveType(typeId: 3, adapterName: 'AccountAdapter')
class Account {
  @HiveField(12, defaultValue: '')
  final String accountId;
  @HiveField(13, defaultValue: '')
  final String accountName;
  @HiveField(14, defaultValue: '')
  final String userId;
  @HiveField(15, defaultValue: 0.0)
  final double balance;

  Account({
    this.accountId = '',
    this.accountName = '',
    this.userId = '',
    this.balance = 0.0,
  });

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
