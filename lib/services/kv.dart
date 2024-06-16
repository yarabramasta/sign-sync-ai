import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class KV {
  KV._();

  // ignore: constant_identifier_names
  static const String _keystore_nsp = '_signsyncai_keystore';

  static late Box<bool> _settingBox;

  static Future<void> ensureInitialized() async {
    const secureStorage = FlutterSecureStorage();

    await Hive.initFlutter();

    // await secureStorage.deleteAll();
    // await Hive.deleteFromDisk();

    final encryptionKeyString = await secureStorage.read(key: _keystore_nsp);
    if (encryptionKeyString == null) {
      final key = Hive.generateSecureKey();
      await secureStorage.write(
        key: _keystore_nsp,
        value: base64UrlEncode(key),
      );
    }

    final key = await secureStorage.read(key: _keystore_nsp);
    final encryptionKeyUint8List = base64Url.decode(key!);

    _settingBox = await Hive.openBox<bool>(
      'setting',
      encryptionCipher: HiveAesCipher(encryptionKeyUint8List),
    );
  }

  static Box<bool> get setting => _settingBox;
}
