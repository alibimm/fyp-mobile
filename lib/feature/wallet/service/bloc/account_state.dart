part of 'account_bloc.dart';


abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountError extends AccountState {}

class AccountLoaded extends AccountState {
  final List<Account> accounts;
  final double totalBalance;
  const AccountLoaded({this.accounts = const [], this.totalBalance = 0.0});

  @override
  List<Object> get props => [accounts, totalBalance];
}
