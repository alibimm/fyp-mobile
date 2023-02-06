import '../providers/login_api_provider.dart';

class LoginApiProviderInject {
  static LoginApiProvider? _loginApiProvider;

  LoginApiProviderInject._();

  static LoginApiProvider? loginApiProvider() {
    _loginApiProvider ??= LoginApiProviderImpl();
    return _loginApiProvider;
  }
}
