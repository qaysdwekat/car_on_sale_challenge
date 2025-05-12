import 'package:car_on_sale_challenge/core/network/abstract_network_config_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_config_provider_test.mocks.dart';

class COSNetworkConfigProvider extends Mock implements AbstractNetworkConfigProvider {}

@GenerateMocks([COSNetworkConfigProvider])
void main() {
  AbstractNetworkConfigProvider configProvider = MockCOSNetworkConfigProvider();

  final List<Map<String, dynamic>> headersConfigProviderTestCases = [
    {
      'description': 'Successful Get Headers Config',
      'expectedResult': {'key': 'value'},
      'expectedError': false,
      'error': null,
    },
    {
      'description': 'Exception Get Headers Config',
      'expectedResult': null,
      'expectedError': true,
      'error': Exception('Wrong type of data'),
    },
  ];

  group('Headers Config Provider Test', () {
    for (var testCase in headersConfigProviderTestCases) {
      final description = testCase['description'];
      final expectedResult = testCase['expectedResult'];
      final expectedError = testCase['expectedError'];
      final error = testCase['error'];

      test(description, () async {
        // Mock the getHeaders method in the MockNetworkConfigProvider
        if (expectedError) {
          when(configProvider.getHeaders()).thenThrow(error);
        } else {
          when(configProvider.getHeaders()).thenAnswer((_) async => expectedResult);
        }

        // Call the method and verify the expectations
        try {
          final Map<String, String> result = await configProvider.getHeaders();

          verify(configProvider.getHeaders());

          if (expectedError) {
            fail('Expected an exception but got a result: $result');
          } else {
            expect(result, expectedResult);
          }
        } catch (e) {
          if (!expectedError || e.toString() != error.toString()) {
            rethrow;
          }
          verify(configProvider.getHeaders());
          expect(e, error);
        }
      });
    }
  });
}
