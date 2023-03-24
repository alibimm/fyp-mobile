import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/common/widgets/bottom_navbar.dart';
import 'package:fyp_mobile/common/widgets/placeholder_view.dart';
import 'package:fyp_mobile/feature/home/view/transaction_history.dart';
import 'package:fyp_mobile/feature/transaction/service/cubit/transaction_cubit.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(),
      body: BlocBuilder<TransactionCubit, TransactionState?>(
        builder: (context, state) {
          if (state is TransactionLoaded) {
            final transactions = state.transactions;
            return TransactionHistory(transactions: transactions);
          }
          return const PlaceholderView(title: 'Home page placeholder');
        },
      ),
    );
  }
}
