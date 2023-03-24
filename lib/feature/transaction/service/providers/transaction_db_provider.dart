import 'package:fyp_mobile/constants/constants.dart';
import 'package:fyp_mobile/feature/transaction/model/transaction.dart';
import 'package:fyp_mobile/service/storage/cache_storage.dart';
import 'package:fyp_mobile/service/storage/secure_storage.dart';

abstract class TransactionDBProvider<T> {
  Future cacheData(T data);
  Future<T> getData();
  Future<String?> getToken();
  Future<String?> getUserId();
}

class TransactionDBProviderImpl implements TransactionDBProvider<List<Transaction>> {
  final SecureStorage secureStorage;
  final CacheStorage cacheStorage;
  final String transactionsBoxKey = 'Transactions';

  TransactionDBProviderImpl({
    required this.secureStorage,
    required this.cacheStorage,
  });

  @override
  Future cacheData(List<Transaction> data) async {
    await cacheStorage.cacheData(transactionsBox, transactionsBoxKey, data);
  }

  @override
  Future<List<Transaction>> getData() async {
    final data = await cacheStorage.fetchData(transactionsBox, transactionsBoxKey);
    if (data == null) return [];
    return (data as List).map((e) => e as Transaction).toList();
  }

  @override
  Future<String?> getToken() async => await secureStorage.getData(accessTokenKey);
  @override
  Future<String?> getUserId() async => await secureStorage.getData(mainUserIdKey);
}
