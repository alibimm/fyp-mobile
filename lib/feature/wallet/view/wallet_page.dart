import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/common/utils/app_color.dart';
import 'package:fyp_mobile/common/widgets/placeholder_view.dart';
import 'package:fyp_mobile/feature/wallet/service/bloc/account_bloc.dart';
import 'package:fyp_mobile/feature/wallet/view/wallet_page_view.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Wallet', style: TextStyle(color: AppColor.mainTextColor)),
      ),
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoaded) {
            final accounts = state.accounts;
            return WalletPageView(accounts: accounts);
          }
          return const PlaceholderView(title: 'Wallet page placeholder');
        },
      ),
    );
  }
}
