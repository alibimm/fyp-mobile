import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/feature/home/view/home_page_view.dart';
import 'package:fyp_mobile/feature/profile/views/profile_page.dart';
import 'package:fyp_mobile/feature/stats/views/stats_page.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          children: const [
            HomePageView(),
            StatisticsPage(),
            ProfilePage(),
          ],
        ),
      ),
    );
  }
}
