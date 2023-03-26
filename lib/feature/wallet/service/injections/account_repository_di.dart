import 'package:fyp_mobile/constants/constants.dart';
import 'package:fyp_mobile/service/network_info.dart';

import '../repositories/account_repository.dart';
import 'account_api_provider_di.dart';
import 'account_db_provider_di.dart';

class AccountRepositoryInject {
  static AccountRepository? _accountRepository;

  AccountRepositoryInject._();

  static AccountRepository? accountRepository() {
    _accountRepository ??= AccountRepositoryImpl(
      apiProvider: AccountApiProviderInject.accountApiProvider()!,
      dBProvider: AccountDBProviderInject.accountDBProvider()!,
      networkInfo: getIt<NetworkInfo>(),
    );
    return _accountRepository;
  }
}
