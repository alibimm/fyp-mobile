import 'package:flutter/material.dart';
import 'package:fyp_mobile/common/utils/app_color.dart';
import 'package:fyp_mobile/common/utils/tools.dart';
import 'package:fyp_mobile/feature/home/widgets/transaction_amount.dart';
import 'package:fyp_mobile/feature/transaction/model/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction item;
  const TransactionItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final title = item.category.isEmpty ? 'Uncategorized' : item.category;
    final date = Tools.formatDate(item.date ?? DateTime.now());
    return SizedBox(
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: AppColor.darkBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.money),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
                    Text(
                      date,
                      style: const TextStyle(
                        color: AppColor.secondaryTextColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                TransactionAmount(
                  amount: item.amount,
                  type: item.type,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
