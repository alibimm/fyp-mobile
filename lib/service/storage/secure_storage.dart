import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

abstract class SecureStorage {
  Future<String?> getData(String key);
  Future putData(String key, String? value);
  Future removeData(String key);
  Future removeAllData();
  Future close();
}

@Singleton(as: SecureStorage)
@preResolve
class SecureStorageImpl implements SecureStorage {
  final FlutterSecureStorage storage;
  final GetStorage getStorage;

  SecureStorageImpl._({required this.storage, required this.getStorage});

  @factoryMethod
  static Future<SecureStorage> init(FlutterSecureStorage storage, GetStorage getStorage) async {
    final instance = SecureStorageImpl._(storage: storage, getStorage: getStorage);
    return instance;
  }

  @override
  Future<String?> getData(String key) async {
    try {
      return await storage.read(key: key);
    } on Exception catch (e) {
      log("Secure storage read exception: $e");
    }
    return null;
  }

  @override
  Future putData(String key, String? value) async {
    try {
      await storage.write(key: key, value: value!);
      log("Secure storage key: $key has been updated");
    } on Exception catch (e) {
      log("Secure storage write key exception: $e");
    }
  }

  @override
  Future removeData(String key) async {
    try {
      await storage.delete(key: key);
      log("Secure storage key: $key has been removed");
    } on Exception catch (e) {
      log("Secure storage delete key exception: $e");
    }
  }

  @override
  Future removeAllData() async {
    try {
      await storage.deleteAll();
      log("Secure storage has been cleared");
    } on Exception catch (e) {
      log("Secure storage delete all exception: $e");
    }
  }

  @override
  Future close() async {}
}
