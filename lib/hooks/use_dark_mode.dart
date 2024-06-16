import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:signsyncai/services/kv.dart';

UseDarkMode useDarkMode() {
  final memoized = useMemoized(
    () => KV.setting.listenable(keys: ["is_dark_mode"]),
  );

  final darkMode = useValueListenable(memoized);

  return UseDarkMode(kv: darkMode);
}

class UseDarkMode {
  const UseDarkMode({required Box<bool> kv}) : _kv = kv;

  final Box<bool> _kv;

  bool get isDarkMode => _kv.get("is_dark_mode", defaultValue: false) ?? false;

  void handleChange(bool value) {
    _kv.put("is_dark_mode", value);
  }
}
