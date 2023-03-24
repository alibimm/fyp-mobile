import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/feature/transaction/model/transaction.dart';
import 'package:fyp_mobile/feature/home/widgets/transaction_item.dart';
import 'package:fyp_mobile/feature/transaction/service/cubit/transaction_cubit.dart';

class TransactionHistory extends StatelessWidget {
  final List<Transaction> transactions;
  const TransactionHistory({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => BlocProvider.of<TransactionCubit>(context).loadTransactions(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            for (final item in transactions) 
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TransactionItem(item: item),
              ),
          ],
        ),
      ),
    );
  }
}
