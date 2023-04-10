import 'package:fyp_mobile/constants/constants.dart';
import 'package:fyp_mobile/feature/login/model/main_user.dart';
import 'package:fyp_mobile/service/mixins/api_mixin.dart';

abstract class LoginApiProvider<T> {
  Future<T> login(String email, String password);
  Future<dynamic> register(String email, String password);
}

class LoginApiProviderImpl with ApiMixin implements LoginApiProvider<MainUser> {
  @override
  Future<MainUser> login(String email, String password) async {
    final object = await fetchData(
        endPoint: authenticationEndpoint,
        body: {'strategy': 'local', 'email': email, 'password': password});
    return MainUser.fromJson(object);
  }
  @override
  Future<dynamic> register(String email, String password) async {
    final object = await fetchData(
        endPoint: usersEndpoint,
        body: {'email': email, 'password': password});
    return object;
  }
}
