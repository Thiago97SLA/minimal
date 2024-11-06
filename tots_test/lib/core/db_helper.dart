import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tots_test/core/error/failure.dart';

final dbHelperProvider = Provider<DbHelper>((_) => DbHelperImpl());

abstract class DbHelper {
  Future<dynamic> getData({required String key, required String boxName});
  Future<Failure?> put(
      {required String key, required dynamic data, required String boxName});
  Future<Failure?> delete({required String key, required String boxName});
  Future<Failure?> update(
      {required String key, required dynamic data, required String boxName});
  String keyToBase64(String key);
}

class DbHelperImpl implements DbHelper {
  @override
  Future<Failure?> put({
    required String key,
    required dynamic data,
    required String boxName,
  }) async {
    try {
      final key0 = keyToBase64(key);
      final box = await getEncryptedBox(boxName: boxName);
      await box.put(key0, data);
      return null;
    } catch (e) {
      return Failure(message: e.toString());
    }
  }

  @override
  Future<Failure?> delete(
      {required String key, required String boxName}) async {
    try {
      final key0 = keyToBase64(key);
      final box = await getEncryptedBox(boxName: boxName);
      await box.delete(key0);
      return null;
    } catch (e) {
      return Failure(message: e.toString());
    }
  }

  @override
  Future<dynamic> getData(
      {required String key, required String boxName}) async {
    try {
      final key0 = keyToBase64(key);
      final box = await getEncryptedBox(boxName: boxName);
      return box.get(key0);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<Failure?> update({
    required String key,
    required dynamic data,
    required String boxName,
  }) async {
    try {
      final key0 = keyToBase64(key);
      final box = await getEncryptedBox(boxName: boxName);
      await box.put(key0, data);
      return null;
    } catch (e) {
      return Failure(message: e.toString());
    }
  }

  Future<Box<dynamic>> getEncryptedBox({required String boxName}) async {
    try {
      final boxName0 = keyToBase64(boxName);
      if (Hive.isBoxOpen(boxName0)) {
        return Hive.box(boxName0);
      }

      final enKey = keyToBase64('enc_key');
      const secureStorage = FlutterSecureStorage();
      final encryptionKey = await secureStorage.read(key: enKey);
      if (encryptionKey == null) {
        final key = Hive.generateSecureKey();
        await secureStorage.write(key: enKey, value: base64UrlEncode(key));
      }
      final key = await secureStorage.read(key: enKey);
      final newEncryptionKey = base64Url.decode(key!);
      return await Hive.openBox(boxName0,
          encryptionCipher: HiveAesCipher(newEncryptionKey));
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  String keyToBase64(String key) {
    return base64Encode(utf8.encode(key));
  }
}
