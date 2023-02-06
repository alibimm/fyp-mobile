import 'dart:convert';

import 'package:fyp_mobile/feature/login/model/main_user.dart';
import 'package:fyp_mobile/service/storage/secure_storage.dart';

abstract class LoginDBProvider<T> {
  Future<String?> getToken();
  Future getUser();
  Future removeUser();
  Future storeUser(T object, String email, String password);
}

class LoginDBProviderImpl implements LoginDBProvider {
  final SecureStorage secureStorage;

  LoginDBProviderImpl({required this.secureStorage});

  @override
  Future<String?> getToken() async =>
      await secureStorage.getData('AccessToken');

  @override
  Future<String?> getUser() async => await secureStorage.getData('MainUser');

  @override
  Future removeUser() async {
    await secureStorage.removeData('AccessToken');
    await secureStorage.removeData('MainUser');
  }

  @override
  Future storeUser(dynamic object, String username, String password) async {
    final MainUser mainUser = object;
    secureStorage
      ..putData('MainUser', json.encode(mainUser.toJson()))
      ..putData('AccessToken', mainUser.accessToken);
  }
}
