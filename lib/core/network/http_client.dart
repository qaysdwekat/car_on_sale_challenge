import 'package:http/http.dart' show BaseClient, ClientException;

import '../exceptions/app_exception.dart';
import 'abstract_http_network.dart';
import 'abstract_network_config_provider.dart';
import 'server_response.dart';

class CosHttpClient implements AbstractHttpNetwork {
  final String baseUrl;
  final AbstractNetworkConfigProvider config;
  final BaseClient httpClient;

  CosHttpClient(this.baseUrl, this.httpClient, this.config);

  @override
  Future<ServerResponse> makeGetRequest(String path, {String? token, Map<String, dynamic>? queryParameters}) async {
    try {
      final uri = Uri.parse('$baseUrl$path');
      final headers = await config.getHeaders();
      final response = await httpClient.get(uri, headers: headers);
      final serverResponse = ServerResponse(data: response.body, statusCode: response.statusCode);
      final data = serverResponse.getData();
      if (serverResponse.multipleChoices) {
        throw MultipleChoicesException<List<dynamic>>(data: data, message: 'Redirect');
      }
      return serverResponse;
    } on ClientException catch (e) {
      throw UnauthorizedException(message: e.message);
    } on AppException catch (_) {
      rethrow;
    } catch (e) {
      throw GeneralException(debugMessage: e.toString());
    }
  }
}
