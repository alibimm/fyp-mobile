import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/constants/keys.dart';
import 'package:fyp_mobile/feature/transaction/service/cubit/transaction_cubit.dart';
import 'package:fyp_mobile/feature/wallet/service/bloc/account_bloc.dart';
import 'package:fyp_mobile/service/navigation/custom_router.dart';

class NavWrapper extends StatefulWidget {
  const NavWrapper({super.key});

  @override
  State<NavWrapper> createState() => _NavWrapperState();
}

class _NavWrapperState extends State<NavWrapper> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TransactionCubit>(context).init();
    BlocProvider.of<AccountBloc>(context).init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: Keys.customNavigationKey,
        initialRoute: 'home',
        onGenerateRoute: CustomRouter.generateRoute,
      ),
    );
  }
}
