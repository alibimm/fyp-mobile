import 'package:fyp_mobile/constants/constants.dart';
import 'package:fyp_mobile/feature/transaction/model/transaction.dart';
import 'package:fyp_mobile/service/mixins/api_mixin.dart';

abstract class TransactionApiProvider<T> {
  Future<T> fetchTransactions(String? token, String userId);
}

class TransactionApiProviderImpl with ApiMixin implements TransactionApiProvider<List<Transaction>> {
  @override
  Future<List<Transaction>> fetchTransactions(String? token, String userId) async {
    final query = {userId: userId};
    final response = await fetchData(endPoint: transactionEndpoint, token: token, query: query);
    final transactions = (response['data'] as List).map((e) => Transaction.fromJson(e)).toList();
    return transactions;
  }
}
