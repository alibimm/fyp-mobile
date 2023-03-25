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
  const TransactionLoaded({this.transactions = const []});

  @override
  List<Object> get props => [transactions];
}
