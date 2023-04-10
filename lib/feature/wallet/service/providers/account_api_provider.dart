import 'dart:convert';
import 'dart:developer';

import 'package:fyp_mobile/constants/constants.dart';
import 'package:fyp_mobile/feature/wallet/model/account.dart';
import 'package:fyp_mobile/service/mixins/api_mixin.dart';

abstract class AccountApiProvider<T> {
  Future<List<T>> fetchAccounts(String? token, String userId);
  Future<T> createAccount(String? token, T object);
}

class AccountApiProviderImpl with ApiMixin implements AccountApiProvider<Account> {
  @override
  Future<List<Account>> fetchAccounts(String? token, String userId) async {
    final response = await fetchData(endPoint: '$accountEndpoint?userId=$userId', token: token);
    final accounts = (response['data'] as List).map((e) => Account.fromJson(e)).toList();
    return accounts;
  }

  @override
  Future<Account> createAccount(String? token, Account object) async {
    final body = {
      "accountName": object.accountName,
      "userId": object.userId,
    };
    final response = await fetchData(endPoint: accountEndpoint, token: token, body: body);
    log(response);
    return Account.fromJson(jsonDecode(response['data']));
  }
}
