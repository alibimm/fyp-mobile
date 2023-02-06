import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fyp_mobile/constants/constants.dart';
import 'package:fyp_mobile/feature/transaction/model/transaction.dart';
import 'package:fyp_mobile/service/mixins/api_mixin.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> with ApiMixin {
  TransactionCubit() : super(TransactionInitial());

  Future<bool> loadTransactions(String userId, String? token) async {
    final response =
        await fetchData(endPoint: transactionEndpoint, token: token, query: {userId: userId});
    final transactions = (response['data'] as List).map((e) => Transaction.fromJson(e)).toList();
    emit(TransactionLoaded(transactions: transactions));
    return true;
  }
}
