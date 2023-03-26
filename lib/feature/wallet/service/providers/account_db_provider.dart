import 'package:fyp_mobile/constants/constants.dart';
import 'package:fyp_mobile/feature/wallet/model/account.dart';
import 'package:fyp_mobile/service/storage/cache_storage.dart';
import 'package:fyp_mobile/service/storage/secure_storage.dart';

abstract class AccountDBProvider<T> {
  Future cacheData(T data);
  Future<T> getData();
  Future<String?> getToken();
  Future<String?> getUserId();
}

class AccountDBProviderImpl implements AccountDBProvider<List<Account>> {
  final SecureStorage secureStorage;
  final CacheStorage cacheStorage;
  final String accountsBoxKey = 'Accounts';

  AccountDBProviderImpl({
    required this.secureStorage,
    required this.cacheStorage,
  });

  @override
  Future cacheData(List<Account> data) async {
    await cacheStorage.cacheData(accountsBox, accountsBoxKey, data);
  }

  @override
  Future<List<Account>> getData() async {
    final data = await cacheStorage.fetchData(accountsBox, accountsBoxKey);
    if (data == null) return [];
    return (data as List).map((e) => e as Account).toList();
  }

  @override
  Future<String?> getToken() async => await secureStorage.getData(accessTokenKey);
  @override
  Future<String?> getUserId() async => await secureStorage.getData(mainUserIdKey);
}
