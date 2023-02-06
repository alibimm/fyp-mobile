import 'package:fyp_mobile/constants/constants.dart';
import 'package:fyp_mobile/service/storage/secure_storage.dart';

import '../providers/login_db_provider.dart';

class LoginDBProviderInject {
  static LoginDBProvider? _loginDBProvider;

  LoginDBProviderInject._();

  static LoginDBProvider? loginDBProvider() {
    _loginDBProvider ??=
        LoginDBProviderImpl(secureStorage: getIt<SecureStorage>());
    return _loginDBProvider;
  }
}
