import 'index.dart' show StorageKey;

abstract class AbstractStorage {
  Future<void> init();
  Future<void> write(StorageKey key, String value);
  Future<String?> read(StorageKey key);
  Future<void> remove(StorageKey key);
  Future<void> clear();
}
