import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/common/utils/app_color.dart';
import 'package:fyp_mobile/common/utils/extensions.dart';
import 'package:fyp_mobile/common/utils/style.dart';
import 'package:fyp_mobile/feature/transaction/service/cubit/transaction_cubit.dart';
import 'package:fyp_mobile/feature/wallet/service/bloc/account_bloc.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: AppColor.primaryItemColor, boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          offset: const Offset(0, 4),
          spreadRadius: 0,
          blurRadius: 4,
        )
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total balance', style: AppStyles.backgroundColorTextStyle.copyWith(fontSize: 16)),
              6.0.vSpace,
              BlocBuilder<AccountBloc, AccountState>(
                builder: (context, state) {
                  if (state is AccountLoaded) {
                    final balance = state.totalBalance;
                    return Text('\$$balance', style: AppStyles.backgroundColorTextStyle.copyWith(fontSize: 30, fontWeight: FontWeight.bold));
                  }
                  return Text('\$0.0', style: AppStyles.backgroundColorTextStyle.copyWith(fontSize: 30, fontWeight: FontWeight.bold));
                },
              ),
            ],
          ),
          16.0.vSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white.withOpacity(0.15),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_upward,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      8.0.hSpace,
                      Text(
                        'Income',
                        style: AppStyles.backgroundColorTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  6.0.vSpace,
                  BlocBuilder<TransactionCubit, TransactionState>(builder: (context, state) {
                    if (state is TransactionLoaded) {
                      final income = state.lastMonthIncome;
                      return Text('\$$income', style: AppStyles.backgroundColorTextStyle.copyWith(fontSize: 20));
                    }
                    return Text('\$0.0', style: AppStyles.backgroundColorTextStyle.copyWith(fontSize: 20));
                  }),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white.withOpacity(0.15),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_upward,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      8.0.hSpace,
                      Text(
                        'Expenses',
                        style: AppStyles.backgroundColorTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  6.0.vSpace,
                  BlocBuilder<TransactionCubit, TransactionState>(builder: (context, state) {
                    if (state is TransactionLoaded) {
                      final expenses = state.lastMonthExpenses;
                      return Text('\$$expenses', style: AppStyles.backgroundColorTextStyle.copyWith(fontSize: 20));
                    }
                    return Text('\$0.0', style: AppStyles.backgroundColorTextStyle.copyWith(fontSize: 20));
                  }),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
