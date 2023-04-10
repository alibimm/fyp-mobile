import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/common/utils/extensions.dart';
import 'package:fyp_mobile/feature/wallet/model/account.dart';
import 'package:fyp_mobile/feature/wallet/service/bloc/account_bloc.dart';
import 'package:fyp_mobile/feature/wallet/widgets/account_card.dart';

class WalletPageView extends StatelessWidget {
  const WalletPageView({super.key, required this.accounts});

  final List<Account> accounts;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => BlocProvider.of<AccountBloc>(context).loadAccounts(),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    for (int i = 0; i < accounts.length; i++) ...[
                      if (i != 0) 16.0.vSpace,
                      AccountCard(account: accounts[i]),
                    ]
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
