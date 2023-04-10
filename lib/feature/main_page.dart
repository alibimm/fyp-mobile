import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/common/utils/app_color.dart';
import 'package:fyp_mobile/common/widgets/bottom_navbar.dart';
import 'package:fyp_mobile/feature/home/view/home_page.dart';
import 'package:fyp_mobile/feature/profile/views/profile_page.dart';
import 'package:fyp_mobile/feature/stats/views/stats_page.dart';
import 'package:fyp_mobile/feature/transaction/service/cubit/transaction_cubit.dart';
import 'package:fyp_mobile/feature/wallet/service/bloc/account_bloc.dart';
import 'package:fyp_mobile/feature/wallet/view/wallet_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final PageController _controller;
  int _selected = 0;
  @override
  void initState() {
    super.initState();
    _controller = PageController();
    loadData();
  }

  void loadData() async {
    BlocProvider.of<TransactionCubit>(context).loadTransactions();
    BlocProvider.of<AccountBloc>(context).loadAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (page) {
          setState(() {
            _selected = page;
          });
        },
        children: const [
          HomePage(),
          StatisticsPage(),
          WalletPage(),
          ProfilePage(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.floatingActionButtonColor,
        onPressed: () => Navigator.pushNamed(context, 'create_transaction'),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        icons: const [Icons.home, Icons.bar_chart, Icons.wallet, Icons.person],
        selectedIndex: _selected,
        addMidSpace: true,
        onSelect: (ind) {
          _controller.animateToPage(ind, duration: const Duration(microseconds: 1000), curve: Curves.ease);
        },
      ),
    );
  }
}
