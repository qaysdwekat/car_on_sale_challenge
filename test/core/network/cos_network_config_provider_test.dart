import 'package:car_on_sale_challenge/core/cos_challenge.dart' show CosChallenge;
import 'package:car_on_sale_challenge/core/network/abstract_network_config_provider.dart';
import 'package:car_on_sale_challenge/core/network/cos_network_config_provider.dart';
import 'package:car_on_sale_challenge/core/storage/index.dart' show AbstractStorage, StorageKey;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cos_network_config_provider_test.mocks.dart';

class SharedPreferencesStorage extends Mock implements AbstractStorage {}

@GenerateMocks([SharedPreferencesStorage])
void main() {
  AbstractStorage storage = MockSharedPreferencesStorage();

  AbstractNetworkConfigProvider configProvider = CosNetworkConfigProvider(storage);

  final List<Map<String, dynamic>> cosHeadersConfigProviderTestCases = [
    {
      'description': 'Successful Get Headers Config With User key',
      'expectedResult': 'value',
      'expectedError': false,
      'error': null,
    },
    {
      'description': 'Exception Get Headers Config With missing User key',
      'expectedResult': Future.value({'key': 'value'}),
      'expectedError': true,
      'error': Exception('User key is missing'),
    },
  ];

  group('COS Headers Config Provider Test', () {
    for (var testCase in cosHeadersConfigProviderTestCases) {
      final description = testCase['description'];
      final expectedResult = testCase['expectedResult'];
      final expectedError = testCase['expectedError'];
      final error = testCase['error'];

      test(description, () async {
        // Mock the getHeaders method in the MockNetworkConfigProvider
        if (expectedError) {
          when(storage.read(StorageKey.username)).thenThrow(error);
        } else {
          when(storage.read(StorageKey.username)).thenAnswer((_) async => expectedResult);
        }

        // Call the method and verify the expectations
        try {
          final Map<String, String> result = await configProvider.getHeaders();

          verify(configProvider.getHeaders());

          if (expectedError) {
            fail('Expected an exception but got a result: $result');
          } else {
            expect(result, {CosChallenge.user: expectedResult});
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
