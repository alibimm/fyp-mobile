import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/feature/transaction/cubit/transaction_cubit.dart';

class LifecycleWatcherProvider extends StatelessWidget {
  final Widget child;
  const LifecycleWatcherProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => TransactionCubit())
      ],
      child: child,
    );
  }
}
