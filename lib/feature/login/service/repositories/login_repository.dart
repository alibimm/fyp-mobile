import 'package:fyp_mobile/feature/login/model/main_user.dart';
import 'package:fyp_mobile/service/models/api_response.dart';
import 'package:fyp_mobile/service/network_info.dart';
import 'dart:convert';

import '../providers/login_api_provider.dart';
import '../providers/login_db_provider.dart';

abstract class LoginRepository<T> {
  Future<T> login(String email, String password);
  Future<ApiResponse> logout();
  Future<ApiResponse> getUser();
  Future<String?> getToken();
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
  Future<ApiResponse> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final String? token = await dBProvider.getToken();
        final data = await apiProvider.login(email, password, token);
        dBProvider.storeUser(data, email, password);
        return ApiResponse.success(data);
      } on Exception catch (e) {
        return ApiResponse.withError(e.toString());
      }
    } else {
      return ApiResponse.withError('Network Connection Error');
    }
  }

  @override
  Future<ApiResponse> logout() async {
    try {
      await dBProvider.removeUser();
      return ApiResponse.success(null);
    } on Exception catch (e) {
      return ApiResponse.withError(e.toString());
    }
  }

  @override
  Future<ApiResponse> getUser() async {
    final rawUser = await dBProvider.getUser();
    if (rawUser != null) {
      final mainUser = MainUser.fromJson(json.decode(rawUser!));
      return ApiResponse.success(mainUser);
    }
    return ApiResponse.withError(null);
  }

  @override
  Future<String?> getToken() async => await dBProvider.getToken();
}
