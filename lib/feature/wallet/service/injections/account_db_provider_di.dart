import 'package:fyp_mobile/constants/constants.dart';
import 'package:fyp_mobile/service/storage/cache_storage.dart';
import 'package:fyp_mobile/service/storage/secure_storage.dart';

import '../providers/account_db_provider.dart';

class AccountDBProviderInject {
  static AccountDBProvider? _accountDBProvider;

  AccountDBProviderInject._();

  static AccountDBProvider? accountDBProvider() {
    _accountDBProvider ??= AccountDBProviderImpl(
      secureStorage: getIt<SecureStorage>(),
      cacheStorage: getIt<CacheStorage>(),
    );
    return _accountDBProvider;
  }
}
