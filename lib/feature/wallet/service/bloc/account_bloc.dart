import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fyp_mobile/feature/wallet/model/account.dart';
import 'package:fyp_mobile/feature/wallet/service/helper/calculations.dart';
import 'package:fyp_mobile/feature/wallet/service/repositories/account_repository.dart';
import 'package:fyp_mobile/service/loader_indicator.dart';
import 'package:fyp_mobile/service/message_dialog.dart';

part 'account_state.dart';

abstract class AccountBloc extends Cubit<AccountState> {
  AccountBloc(AccountState state) : super(state);
  Future init();
  Future loadAccounts();
  Future createAccount(String accountName);
}

class AccountBlocImpl extends AccountBloc {
  final AccountRepository repository;
  final LoaderIndicator loaderIndicator;
  final MessageDialog messageDialog;

  AccountBlocImpl({
    required this.repository,
    required this.loaderIndicator,
    required this.messageDialog,
  }) : super(AccountInitial());

  @override
  Future init() async {
    loaderIndicator.run();
    final data = await repository.fetchFromCache();
    if (data.object != null) {
      final accounts = data.object as List<Account>;
      final balance = CalculateAccounts.calculateTotalBalance(accounts);
      emit(AccountLoaded(accounts: accounts, totalBalance: balance));
    } else {
      emit(AccountInitial());
    }
  }

  @override
  Future loadAccounts() async {
    loaderIndicator.run();
    final data = await repository.fetchFromApi();
    if (data.object != null) {
      final accounts = data.object as List<Account>;
      final balance = CalculateAccounts.calculateTotalBalance(accounts);
      emit(AccountLoaded(accounts: accounts, totalBalance: balance));
    } else {
      messageDialog.show(message: data.errorMessage ?? 'Cannot load accounts');
    }
    loaderIndicator.stop();
  }

  @override
  Future createAccount(String accountName) async {
    loaderIndicator.run();
    final data = await repository.createAccount(accountName);
    if (data.object != null) {
      messageDialog.show(message: 'Created an account');
      loadAccounts();
    } else {
      messageDialog.show(message: data.errorMessage ?? 'Cannot load accounts');
    }
    loaderIndicator.stop();
  }
}
