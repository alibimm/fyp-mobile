import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/constants/constants.dart';
import 'package:fyp_mobile/feature/transaction/service/cubit/transaction_cubit.dart';
import 'package:fyp_mobile/feature/transaction/service/injections/transaction_repository_di.dart';
import 'package:fyp_mobile/feature/wallet/service/bloc/account_bloc.dart';
import 'package:fyp_mobile/feature/wallet/service/injections/account_repository_di.dart';
import 'package:fyp_mobile/service/loader_indicator.dart';
import 'package:fyp_mobile/service/message_dialog.dart';

class LifecycleWatcherProvider extends StatelessWidget {
  final Widget child;
  const LifecycleWatcherProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TransactionCubit>(
          create: (BuildContext context) => TransactionCubitImpl(
            repository: TransactionRepositoryInject.transactionRepository()!,
            loaderIndicator: getIt<LoaderIndicator>(),
            messageDialog: getIt<MessageDialog>(),
          ),
        ),
        BlocProvider<AccountBloc>(
          create: (BuildContext context) => AccountBlocImpl(
            repository: AccountRepositoryInject.accountRepository()!,
            loaderIndicator: getIt<LoaderIndicator>(),
            messageDialog: getIt<MessageDialog>(),
          ),
        )
      ],
      child: child,
    );
  }
}
