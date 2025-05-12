abstract class AbstractAuthDatasource {
  Future<String> login(String username);
  Future<String?> getUserInfo();
}
