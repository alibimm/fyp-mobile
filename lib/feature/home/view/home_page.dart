import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/feature/login/model/main_user.dart';
import 'package:fyp_mobile/feature/login/service/cubit/login_cubit.dart';
import 'package:fyp_mobile/feature/transaction/service/cubit/transaction_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadTransactions();
  }

  void loadTransactions() async {
    BlocProvider.of<TransactionCubit>(context).loadTransactions();
  }

  void logout(BuildContext context) {
    BlocProvider.of<LoginBloc>(context).logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<TransactionCubit, TransactionState?>(
              builder: (context, state) {
                if (state is TransactionLoading) {
                  return const Text('Loading');
                } else if (state is TransactionLoaded) {
                  final transactions = state.transactions;
                  return Expanded(
                    child: ListView.separated(
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        final t = transactions[index];
                        return Column(
                          children: [
                            Text(t.type.toString()),
                            Text('${t.baseAccount}${t.destinationAccount != null ? ' -> ${t.destinationAccount}' : ''}'),
                            Text(t.amount.toString()),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    ),
                  );
                }
                return const Text("Initial");
              },
            ),
            TextButton(
              onPressed: loadTransactions,
              child: const Text('Reload'),
            ),
            BlocBuilder<LoginBloc, MainUser?>(
              builder: (context, user) {
                final email = user!.user?.email ?? 'no user';
                return Text(email);
              },
            ),
            TextButton(
              onPressed: () => logout(context),
              child: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
