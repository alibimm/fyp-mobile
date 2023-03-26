part of 'transaction_cubit.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionError extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;
  final double lastMonthExpenses;
  final double lastMonthIncome;
  const TransactionLoaded({this.transactions = const [], this.lastMonthExpenses = 0.0, this.lastMonthIncome = 0.0});

  @override
  List<Object> get props => [transactions, lastMonthExpenses, lastMonthIncome];
}
