import '../../../../core/storage/index.dart' show AbstractStorage, StorageKey;
import 'abstract_auth_datasource.dart' show AbstractAuthDatasource;

class AuthDatasource implements AbstractAuthDatasource {
  final AbstractStorage storage;

  AuthDatasource(this.storage);

  @override
  Future<String> login(String username) async {
    await storage.write(StorageKey.username, username);
    return username;
  }

  @override
  Future<String?> getUserInfo() async {
    return storage.read(StorageKey.username);
  }
}
