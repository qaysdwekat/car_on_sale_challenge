import 'package:shared_preferences/shared_preferences.dart';

import 'index.dart' show AbstractStorage, StorageKey;

class SharedPreferencesStorage implements AbstractStorage {
  late SharedPreferences preferences;
  SharedPreferencesStorage();

  @override
  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Future<void> clear() async {
    await preferences.clear();
  }

  @override
  Future<String?> read(StorageKey key) async {
    return preferences.getString(key.name);
  }

  @override
  Future<void> remove(StorageKey key) async {
    await preferences.remove(key.name);
  }

  @override
  Future<void> write(StorageKey key, String value) async {
    await preferences.setString(key.name, value);
  }
}
