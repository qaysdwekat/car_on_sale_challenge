import '../cos_challenge.dart';
import 'abstract_http_network.dart';
import 'abstract_network_config_provider.dart';
import 'server_response.dart';

class CosHttpClient implements AbstractHttpNetwork {
  final String baseUrl;
  final AbstractNetworkConfigProvider config;

  CosHttpClient(this.baseUrl, this.config);

  @override
  Future<ServerResponse> makeGetRequest(String path, {String? token, Map<String, dynamic>? queryParameters}) async {
    final uri = Uri.parse('$baseUrl$path');
    final headers = await config.getHeaders();
    final response = await CosChallenge.httpClient.get(uri, headers: headers);
    return ServerResponse(data: response.body, statusCode: response.statusCode);
  }
}
