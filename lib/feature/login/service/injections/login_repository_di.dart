import 'package:fyp_mobile/constants/constants.dart';
import 'package:fyp_mobile/service/network_info.dart';

import '../repositories/login_repository.dart';
import 'login_api_provider_di.dart';
import 'login_db_provider_di.dart';

class LoginRepositoryInject {
  static LoginRepository? _loginRepository;

  LoginRepositoryInject._();

  static LoginRepository? loginRepository() {
    _loginRepository ??= LoginRepositoryImpl(
      apiProvider: LoginApiProviderInject.loginApiProvider()!,
      dBProvider: LoginDBProviderInject.loginDBProvider()!,
      networkInfo: getIt<NetworkInfo>(),
    );
    return _loginRepository;
  }
}
