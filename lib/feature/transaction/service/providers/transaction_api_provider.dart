
import 'package:fyp_mobile/constants/constants.dart';
import 'package:fyp_mobile/feature/transaction/model/transaction.dart';
import 'package:fyp_mobile/service/mixins/api_mixin.dart';

abstract class TransactionApiProvider<T> {
  Future<List<T>> fetchTransactions(String? token, String userId);
  Future<T> createTransactions(String? token, T object);
}

class TransactionApiProviderImpl with ApiMixin implements TransactionApiProvider<Transaction> {
  @override
  Future<List<Transaction>> fetchTransactions(String? token, String userId) async {
    final query = {'userId': userId, '\$limit': 200};
    final response = await fetchData(endPoint: transactionEndpoint, token: token, query: query);
    final transactions = (response['data'] as List).map((e) => Transaction.fromJson(e)).toList();
    return transactions;
  }

  @override
  Future<Transaction> createTransactions(String? token, Transaction object) async {
    final body = {
      "userId": object.userId,
      "amount": object.amount.toString(),
      "type": object.type == TransactionType.income ? 'income' : 'expense',
      "category": object.category,
      "baseAccount": object.baseAccount,
      "date": object.date.toString(),
    };
    await fetchData(endPoint: transactionEndpoint, token: token, body: body);
    return object;
  }
}
