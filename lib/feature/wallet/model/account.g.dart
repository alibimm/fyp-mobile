// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountAdapter extends TypeAdapter<Account> {
  @override
  final int typeId = 3;

  @override
  Account read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Account(
      accountId: fields[12] == null ? '' : fields[12] as String,
      accountName: fields[13] == null ? '' : fields[13] as String,
      userId: fields[14] == null ? '' : fields[14] as String,
      balance: fields[15] == null ? 0.0 : fields[15] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Account obj) {
    writer
      ..writeByte(4)
      ..writeByte(12)
      ..write(obj.accountId)
      ..writeByte(13)
      ..write(obj.accountName)
      ..writeByte(14)
      ..write(obj.userId)
      ..writeByte(15)
      ..write(obj.balance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      accountId: json['accountId'] as String? ?? '',
      accountName: json['accountName'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'accountId': instance.accountId,
      'accountName': instance.accountName,
      'userId': instance.userId,
      'balance': instance.balance,
    };
