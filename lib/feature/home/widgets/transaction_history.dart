import 'package:flutter/material.dart';
import 'package:fyp_mobile/common/utils/extensions.dart';
import 'package:fyp_mobile/common/utils/style.dart';
import 'package:fyp_mobile/feature/home/widgets/transaction_item.dart';
import 'package:fyp_mobile/feature/transaction/model/transaction.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({super.key, required this.transactions});
  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Transaction History', style: AppStyles.primaryTextStyle.copyWith(fontSize: 18)),
        12.0.vSpace,
        for (int i = 0; i < transactions.length; i++) ...[
          if (i != 0) 16.0.vSpace,
          TransactionItem(item: transactions[i]),
        ],
      ],
    );
  }
}
