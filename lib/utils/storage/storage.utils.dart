import 'package:cross_local_storage/cross_local_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io' show Platform;

class StorageUtils {
  static dynamic saveOrGet(String key, {String value}) async {
    if (kIsWeb || Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      final LocalStorageInterface localStorage =
          await LocalStorage.getInstance();

      if (value != null) {
        localStorage.setString(key, value);
      } else {
        return localStorage.getString(key);
      }

      return;
    }

    if (value != null) {
      FlutterSecureStorage().write(key: key, value: value);
    } else {
      return FlutterSecureStorage().read(key: key);
    }
  }
}
