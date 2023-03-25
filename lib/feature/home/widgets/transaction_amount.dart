import 'package:flutter/material.dart';
import 'package:fyp_mobile/common/utils/app_color.dart';
import 'package:fyp_mobile/constants/constants.dart';
import 'package:fyp_mobile/feature/transaction/model/transaction.dart';

class TransactionAmount extends StatelessWidget {
  final double amount;
  final TransactionType type;
  const TransactionAmount({super.key, required this.amount, required this.type});

  Color getColor(TransactionType type) {
    switch (type) {
      case TransactionType.expense:
        return AppColor.expenseColor;
      case TransactionType.income:
        return AppColor.incomeColor;
      case TransactionType.transfer:
        return AppColor.transferColor;
      default:
        return AppColor.mainTextColor;
    }
  }

  String getText(double amount, TransactionType type) {
    final sign = type == TransactionType.expense ? '-' : (type == TransactionType.income ? '+' : '');
    final value = amount.toStringAsFixed(doublePresicion);
    return '$sign \$$value';
  }

  @override
  Widget build(BuildContext context) {
    final text = getText(amount, type);
    final color = getColor(type);
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
