import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fyp_mobile/constants/constants.dart';
import 'package:fyp_mobile/feature/transaction/model/transaction.dart';
import 'package:fyp_mobile/feature/wallet/model/account.dart';
import 'package:fyp_mobile/service/loader_indicator.dart';
import 'package:fyp_mobile/service/message_dialog.dart';
import 'package:fyp_mobile/service/network_info.dart';
import 'package:fyp_mobile/service/storage/cache_storage.dart';
import 'package:fyp_mobile/service/storage/secure_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

Future setup() async {
  const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
  final HiveInterface hive = Hive;
  final GetStorage getStorage = GetStorage();
  final connectionChecker = InternetConnectionChecker();

  getIt.registerSingleton<SecureStorage>(await SecureStorageImpl.init(flutterSecureStorage, getStorage));
  getIt.registerSingleton<CacheStorage>(await CacheStorageImpl.init(hive: hive, getStorage: getStorage));
  getIt.registerSingleton<NetworkInfo>(NetworkInfo(connectionChecker: connectionChecker));
  getIt.registerSingleton<LoaderIndicator>(LoaderIndicator());
  getIt.registerSingleton<MessageDialog>(MessageDialog());
  getIt.registerSingleton<HiveInterface>(Hive);
}

void registerAdapters() {
  getIt<HiveInterface>()
    ..registerAdapter(TransactionAdapter())
    ..registerAdapter(TransactionTypeAdapter())
    ..registerAdapter(AccountAdapter());
}
