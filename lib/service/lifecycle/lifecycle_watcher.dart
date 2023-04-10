import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/feature/login/service/cubit/login_cubit.dart';
import 'package:fyp_mobile/feature/transaction/service/cubit/transaction_cubit.dart';
import 'package:fyp_mobile/feature/wallet/service/bloc/account_bloc.dart';

class LifecycleWatcher extends StatefulWidget {
  final Widget child;
  const LifecycleWatcher({super.key, required this.child});

  @override
  State<LifecycleWatcher> createState() => _LifecycleWatcherState();
}

class _LifecycleWatcherState extends State<LifecycleWatcher> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    await BlocProvider.of<LoginBloc>(context).initUser();

    if (mounted) {
      BlocProvider.of<LoginBloc>(context).stream.listen((event) {
        if (event != null) {
          BlocProvider.of<AccountBloc>(context).loadAccounts();
          BlocProvider.of<TransactionCubit>(context).loadTransactions();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
