import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/common/utils/app_color.dart';
import 'package:fyp_mobile/common/utils/extensions.dart';
import 'package:fyp_mobile/feature/transaction/service/cubit/transaction_cubit.dart';
import 'package:fyp_mobile/feature/wallet/model/account.dart';
import 'package:fyp_mobile/feature/wallet/service/bloc/account_bloc.dart';
import 'package:fyp_mobile/feature/wallet/widgets/account_card.dart';

class WalletPageView extends StatelessWidget {
  const WalletPageView({super.key, required this.accounts});

  final List<Account> accounts;

  void showCreateAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String inputText = '';
        return AlertDialog(
          title: const Text('What do you want to name the card?'),
          content: TextField(
            onChanged: (value) {
              inputText = value;
            },
          ),
          actions: [
            TextButton(
              child: const Text(
                'CANCEL',
                style: TextStyle(color: AppColor.darkPrimaryColor),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text(
                'CREATE',
                style: TextStyle(color: AppColor.darkPrimaryColor),
              ),
              onPressed: () {
                Navigator.pop(context, inputText);
              },
            ),
          ],
        );
      },
    ).then((value) {
      BlocProvider.of<AccountBloc>(context).createAccount(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<AccountBloc>(context).loadAccounts();
        BlocProvider.of<TransactionCubit>(context).loadTransactions();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                for (int i = 0; i < accounts.length; i++) ...[
                  if (i != 0) 16.0.vSpace,
                  AccountCard(account: accounts[i]),
                ],
                16.0.vSpace,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColor.darkPrimaryColor),
                  onPressed: () {
                    showCreateAccountDialog(context);
                  },
                  child: const Text('Create card'),
                ),
                28.0.vSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
