import 'package:fyp_mobile/feature/transaction/model/transaction.dart';
import 'package:fyp_mobile/feature/transaction/service/providers/transaction_api_provider.dart';
import 'package:fyp_mobile/feature/transaction/service/providers/transaction_db_provider.dart';
import 'package:fyp_mobile/service/models/api_response.dart';
import 'package:fyp_mobile/service/network_info.dart';
import 'package:uuid/uuid.dart';

abstract class TransactionRepository<T> {
  Future<AppResponse> fetchFromApi();
  Future<AppResponse> fetchFromCache();
  Future<AppResponse> createTransaction(double amount, String category, String accountId, DateTime date, String type);
}

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionApiProvider apiProvider;
  final TransactionDBProvider dBProvider;
  final NetworkInfo networkInfo;

  TransactionRepositoryImpl({
    required this.apiProvider,
    required this.dBProvider,
    required this.networkInfo,
  });

  @override
  Future<AppResponse> fetchFromApi() async {
    if (await networkInfo.isConnected) {
      try {
        final token = await dBProvider.getToken();
        final userId = await dBProvider.getUserId() ?? '';
        final data = await apiProvider.fetchTransactions(token, userId);
        dBProvider.cacheData(data);
        return AppResponse.success(data);
      } on Exception catch (e) {
        return AppResponse.withError(e.toString());
      }
    } else {
      return AppResponse.withError('Network Connection Error');
    }
  }

  @override
  Future<AppResponse> fetchFromCache() async {
    try {
      final data = await dBProvider.getData();
      return AppResponse.success(data);
    } on Exception {
      return AppResponse.withError('Couldn\'t load from cache');
    }
  }

  @override
  Future<AppResponse> createTransaction(double amount, String category, String accountId, DateTime date, String type) async {
    try {
      final token = await dBProvider.getToken();
      final userId = await dBProvider.getUserId() ?? '';
      final String id = const Uuid().v4();
      final Transaction transaction = Transaction(
        transactionId: id,
        baseAccount: accountId,
        userId: userId,
        category: category,
        amount: amount,
        date: date,
        type: type == 'Income' ? TransactionType.income : TransactionType.expense,
      );
      final data = apiProvider.createTransactions(token, transaction);
      return AppResponse.success(data);
    } on Exception {
      return AppResponse.withError('Couldn\'t create a transactions');
    }
  }
}
