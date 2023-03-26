import 'package:fyp_mobile/feature/transaction/model/transaction.dart';
import 'package:fyp_mobile/feature/wallet/service/providers/account_api_provider.dart';
import 'package:fyp_mobile/feature/wallet/service/providers/account_db_provider.dart';
import 'package:fyp_mobile/service/models/api_response.dart';
import 'package:fyp_mobile/service/network_info.dart';
import 'package:uuid/uuid.dart';

abstract class AccountRepository<T> {
  Future<AppResponse> fetchFromApi();
  Future<AppResponse> fetchFromCache();
  Future<AppResponse> createAccount(double amount, String category, DateTime date);
}

class AccountRepositoryImpl implements AccountRepository {
  final AccountApiProvider apiProvider;
  final AccountDBProvider dBProvider;
  final NetworkInfo networkInfo;

  AccountRepositoryImpl({
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
        final data = await apiProvider.fetchAccounts(token, userId);
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
  Future<AppResponse> createAccount(double amount, String category, DateTime date) async {
    try {
      final token = await dBProvider.getToken();
      final userId = await dBProvider.getUserId() ?? '';
      final String id = const Uuid().v4();
      final Transaction transaction = Transaction(
        transactionId: id,
        userId: userId,
        category: category,
        amount: amount,
        date: date,
        type: TransactionType.expense, // TODO: add different type support
      );
      final data = apiProvider.createAccount(token, transaction);
      return AppResponse.success(data);
    } on Exception {
      return AppResponse.withError('Couldn\'t create a transactions');
    }
  }
}
