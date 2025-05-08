abstract class AbstractNetworkConfigProvider {
  Future<Map<String, String>> getHeaders();
  int getTimeOut();
}
