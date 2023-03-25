import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/common/widgets/placeholder_view.dart';
import 'package:fyp_mobile/feature/home/view/home_page_view.dart';
import 'package:fyp_mobile/feature/transaction/service/cubit/transaction_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<TransactionCubit, TransactionState?>(
        builder: (context, state) {
          if (state is TransactionLoaded) {
            final transactions = state.transactions;
            return HomePageView(transactions: transactions);
          }
          return const PlaceholderView(title: 'Home page placeholder');
        },
      ),
    );
  }
}
