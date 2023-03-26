
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
    final query = {userId: userId};
    final response = await fetchData(endPoint: transactionEndpoint, token: token, query: query);
    final transactions = (response['data'] as List).map((e) => Transaction.fromJson(e)).toList();
    return transactions;
  }

  @override
  Future<Transaction> createTransactions(String? token, Transaction object) async {
    final body = {
      "userId": object.userId,
      "amount": object.amount.toString(),
      "type": "expense",
      "category": object.category,
      "baseAccount": "0b2f78f9-a7d6-4a49-9661-1770438c0e4c", // TODO: change
      "date": object.date.toString(),
    };
    await fetchData(endPoint: transactionEndpoint, token: token, body: body);
    return object;
  }
}
