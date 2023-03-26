import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fyp_mobile/feature/transaction/model/transaction.dart';
import 'package:fyp_mobile/feature/transaction/service/repositories/transaction_repository.dart';
import 'package:fyp_mobile/service/loader_indicator.dart';
import 'package:fyp_mobile/service/message_dialog.dart';

part 'transaction_state.dart';

abstract class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit(TransactionState state) : super(state);
  Future init();
  Future loadTransactions();
  Future createTransaction(double amount, String category, DateTime date);
}

class TransactionCubitImpl extends TransactionCubit {
  final TransactionRepository repository;
  final LoaderIndicator loaderIndicator;
  final MessageDialog messageDialog;

  TransactionCubitImpl({
    required this.repository,
    required this.loaderIndicator,
    required this.messageDialog,
  }) : super(TransactionInitial());

  @override
  Future init() async {
    loaderIndicator.run();
    final data = await repository.fetchFromCache();
    if (data.object != null) {
      final transactions = data.object as List<Transaction>;
      emit(TransactionLoaded(transactions: transactions));
    } else {
      emit(TransactionInitial());
    }
  }

  @override
  Future loadTransactions() async {
    loaderIndicator.run();
    final data = await repository.fetchFromApi();
    if (data.object != null) {
      final transactions = data.object as List<Transaction>;
      emit(TransactionLoaded(transactions: transactions));
    } else {
      messageDialog.show(message: data.errorMessage ?? 'Cannot load transactions');
    }
    loaderIndicator.stop();
  }
  
  @override
  Future createTransaction(double amount, String category, DateTime date) async {
    loaderIndicator.run();
    final data = await repository.createTransaction(amount, category, date);
    if (data.object != null) {
      messageDialog.show(message: 'Created a transaction');
    } else {
      messageDialog.show(message: data.errorMessage ?? 'Cannot load transactions');
    }
    loaderIndicator.stop();
  }

}
