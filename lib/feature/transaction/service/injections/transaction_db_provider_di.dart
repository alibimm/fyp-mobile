import 'package:fyp_mobile/constants/constants.dart';
import 'package:fyp_mobile/service/storage/cache_storage.dart';
import 'package:fyp_mobile/service/storage/secure_storage.dart';

import '../providers/transaction_db_provider.dart';

class TransactionDBProviderInject {
  static TransactionDBProvider? _transactionDBProvider;

  TransactionDBProviderInject._();

  static TransactionDBProvider? transactionDBProvider() {
    _transactionDBProvider ??= TransactionDBProviderImpl(
      secureStorage: getIt<SecureStorage>(),
      cacheStorage: getIt<CacheStorage>(),
    );
    return _transactionDBProvider;
  }
}
