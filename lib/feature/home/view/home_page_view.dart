import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/common/utils/app_color.dart';
import 'package:fyp_mobile/common/utils/extensions.dart';
import 'package:fyp_mobile/feature/home/widgets/balance_widget.dart';
import 'package:fyp_mobile/feature/home/widgets/greetings_widget.dart';
import 'package:fyp_mobile/feature/home/widgets/transaction_history.dart';
import 'package:fyp_mobile/feature/transaction/model/transaction.dart';
import 'package:fyp_mobile/feature/transaction/service/cubit/transaction_cubit.dart';
import 'package:fyp_mobile/feature/wallet/service/bloc/account_bloc.dart';

class HomePageView extends StatelessWidget {
  final List<Transaction> transactions;
  const HomePageView({super.key, required this.transactions});

  Future<void> fetchData(BuildContext context) async {
    BlocProvider.of<TransactionCubit>(context).loadTransactions();
    BlocProvider.of<AccountBloc>(context).loadAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => fetchData(context),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: AppColor.backgroundElementGradient,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: context.height * 0.3,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            24.0.vSpace,
                            const GreetingsWidget(),
                            24.0.vSpace,
                            const BalanceWidget(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                24.0.vSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TransactionHistory(transactions: transactions),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
