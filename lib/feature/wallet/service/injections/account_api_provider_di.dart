import '../providers/account_api_provider.dart';

class AccountApiProviderInject {
  static AccountApiProvider? _accountApiProvider;

  AccountApiProviderInject._();

  static AccountApiProvider? accountApiProvider() {
    _accountApiProvider ??= AccountApiProviderImpl();
    return _accountApiProvider;
  }
}
