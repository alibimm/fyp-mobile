import 'dart:developer';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fyp_mobile/constants/constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

abstract class CacheStorage<T> {
  Future<T> fetchData(String box, String key);

  Future cacheData(String box, String key, T object);

  Future removeData(String box, String key);

  Future clearCache({bool withDigitalTickets = false});

  Future close();
}

class CacheStorageImpl implements CacheStorage {
  final HiveInterface hive;
  final GetStorage getStorage;

  CacheStorageImpl._({required this.hive, required this.getStorage});

  @factoryMethod
  static Future<CacheStorage> init({
    required HiveInterface hive,
    required GetStorage getStorage,
  }) async {
    final instance = CacheStorageImpl._(hive: hive, getStorage: getStorage);
    await hive.initFlutter();
    return instance;
  }

  @override
  Future cacheData(String box, String key, dynamic object) async {
    try {
      final Box currentBox = await _openHiveBox(box);
      await currentBox.put(key, object).catchError((e) {
        throw e;
      });
    } on Exception catch (e) {
      log("Hive cache storage cache exception: $e");
      rethrow;
    }
  }

  @override
  Future<dynamic> fetchData(String box, String key) async {
    try {
      final Box currentBox = await _openHiveBox(box);
      return await currentBox.get(key, defaultValue: null);
    } on Exception catch (e) {
      log("Hive cache storage read exception: $e");
      rethrow;
    }
  }

  @override
  Future removeData(String box, String key) async {
    try {
      final Box currentBox = await _openHiveBox(box);
      await currentBox.delete(key).catchError((e) {
        throw e;
      });
    } on Exception catch (e) {
      log("Hive cache storage remove exception: $e");
      rethrow;
    }
  }

  @override
  Future clearCache({bool withDigitalTickets = false}) async {
    try {
      for (final boxName in hiveBoxes) {
        await hive.deleteBoxFromDisk(boxName.toString()).catchError((e) {
          throw e;
        });
        log("Hive box: $boxName removed from disk");
      }

      /// clear images from cache
      await DefaultCacheManager().emptyCache();
    } on Exception catch (e) {
      log("Hive cache storage clear exception: $e");
      rethrow;
    }
  }

  @override
  Future close() async {
    hive.close();
  }

  Future<Box> _openHiveBox(String box) async {
    if (hive.isBoxOpen(box)) {
      return hive.box(box);
    }
    final currentBox = await hive.openBox(box).catchError((e, s) {
      hive.deleteBoxFromDisk(box);
      log("Hive cache storage open box crushed and this box is deleted: $e");
      if (!hive.isBoxOpen(defaultBox)) hive.openBox(defaultBox);
      return hive.box(defaultBox);
    });
    return currentBox;
  }
}
