import 'package:car_on_sale_challenge/core/exceptions/app_exception.dart' show UnauthorizedException;
import 'package:car_on_sale_challenge/core/exceptions/index.dart' show MultipleChoicesException;
import 'package:car_on_sale_challenge/core/network/abstract_http_network.dart';
import 'package:car_on_sale_challenge/core/network/abstract_network_config_provider.dart';
import 'package:car_on_sale_challenge/core/network/http_client.dart' show CosHttpClient;
import 'package:car_on_sale_challenge/core/network/server_response.dart';
import 'package:car_on_sale_challenge/features/auction/data/models/vehicle_model.dart' show VehicleModel;
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' show BaseClient, Response;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_client_test.mocks.dart';

// Define a mock class for any dependencies
class CosNetworkConfigProvider extends Mock implements AbstractNetworkConfigProvider {}

class HttpClient extends Mock implements BaseClient {}

@GenerateMocks([CosNetworkConfigProvider, HttpClient])
void main() {
  AbstractNetworkConfigProvider configProvider = MockCosNetworkConfigProvider();

  BaseClient httpClient = MockHttpClient();
  final baseUrl = "someUrl";

  AbstractHttpNetwork cosHttpNetwork = CosHttpClient(baseUrl, httpClient, configProvider);

  final List<Map<String, dynamic>> getRequestwithServerResponseTestCases = [
    {
      'description': 'Unauthorized Exception',
      'path': '/example',
      'headers': <String, String>{},
      'expectedStatusCode': null,
      'expectedResponse': ServerResponse(),
      'expectedError': true,
      'error': UnauthorizedException(message: 'user is missing'),
    },
    {
      'description': 'Successful GET Server Response (200)',
      'path': '/example',
      'headers': <String, String>{'user': 'userId'},
      'expectedStatusCode': 200,
      'expectedResponse': '''{"id": 871235}''',
      'expectedError': false,
      'error': null,
    },
    {
      'description': 'Successful GET Server Response (300)',
      'path': '/example',
      'headers': <String, String>{'user': 'userId'},
      'expectedStatusCode': 300,
      'expectedResponse':
          '''[{"make": "Toyota","model": "GT 86 Basis","containerName": "DE - Cp2 2.0 EU5, 2012 - 2015","similarity": 75,"externalId": "DE001-018601450020001"}]''',
      'expectedError': true,
      'error': MultipleChoicesException(
        data: [
          VehicleModel.fromJson({
            "make": "Toyota",
            "model": "GT 86 Basis",
            "containerName": "DE - Cp2 2.0 EU5, 2012 - 2015",
            "similarity": 75,
            "externalId": "DE001-018601450020001",
          }),
        ],
        message: 'Redirect',
      ),
    },
  ];

  group('Get Request With Mock Server Response Test', () {
    for (var testCase in getRequestwithServerResponseTestCases) {
      final description = testCase['description'];
      final path = testCase['path'];
      final expectedStatusCode = testCase['expectedStatusCode'];
      final expectedResponse = testCase['expectedResponse'];
      final headers = testCase['headers'];
      final expectedError = testCase['expectedError'];
      final error = testCase['error'];
      final uri = Uri.parse('$baseUrl$path');

      test(description, () async {
        // Mock the makeGetRequest method in the MockDioHttpNetwork
        when(configProvider.getHeaders()).thenAnswer((_) async => headers);

        if (expectedError) {
          when(httpClient.get(uri, headers: headers)).thenThrow(error);
        } else {
          when(
            httpClient.get(uri, headers: headers),
          ).thenAnswer((_) async => Response(expectedResponse, expectedStatusCode));
        }

        // Call the method and verify the expectations
        try {
          final result = await cosHttpNetwork.makeGetRequest(path);

          verify(httpClient.get(uri, headers: headers));

          if (expectedError) {
            fail('Expected an exception but got a result: $result');
          } else {
            expect(result.statusCode, expectedStatusCode);
            expect(result.data, expectedResponse);
          }
        } catch (e) {
          if (!expectedError || e.toString() != error.toString()) {
            rethrow;
          }
          verify(httpClient.get(uri, headers: headers));
          expect(e, error);
        }
      });
    }
  });
}
