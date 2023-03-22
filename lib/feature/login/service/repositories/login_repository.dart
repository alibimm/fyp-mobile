import 'package:fyp_mobile/feature/login/model/main_user.dart';
import 'package:fyp_mobile/service/models/api_response.dart';
import 'package:fyp_mobile/service/network_info.dart';
import 'dart:convert';

import '../providers/login_api_provider.dart';
import '../providers/login_db_provider.dart';

abstract class LoginRepository<T> {
  Future<AppResponse> login(String email, String password);
  Future<AppResponse> logout();
  Future<AppResponse> getUser();
}

class LoginRepositoryImpl implements LoginRepository {
  final LoginApiProvider apiProvider;
  final LoginDBProvider dBProvider;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl({
    required this.apiProvider,
    required this.dBProvider,
    required this.networkInfo,
  });

  @override
  Future<AppResponse> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await apiProvider.login(email, password);
        dBProvider.storeUser(data, email, password);
        return AppResponse.success(data);
      } on Exception catch (e) {
        return AppResponse.withError(e.toString());
      }
    } else {
      return AppResponse.withError('Network Connection Error');
    }
  }

  @override
  Future<AppResponse> logout() async {
    try {
      await dBProvider.removeUser();
      return AppResponse.success(null);
    } on Exception catch (e) {
      return AppResponse.withError(e.toString());
    }
  }

  @override
  Future<AppResponse> getUser() async {
    final rawUser = await dBProvider.getUser();
    if (rawUser != null) {
      final mainUser = MainUser.fromJson(json.decode(rawUser!));
      return AppResponse.success(mainUser);
    }
    return AppResponse.withError("User not found");
  }
}
