import 'dart:convert';

import 'package:car_on_sale_challenge/core/storage/index.dart' show AbstractStorage;
import 'package:car_on_sale_challenge/core/storage/storage_key.dart';
import 'package:car_on_sale_challenge/features/auction/data/datasources/index.dart'
    show AbstractAuctionLocalDatasource, AuctionLocalDatasource;
import 'package:car_on_sale_challenge/features/auction/data/models/auction_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/fixture_reader.dart';
import 'auction_local_datasoure_test.mocks.dart';

class SharedPreferencesStorage extends Mock implements AbstractStorage {}

@GenerateMocks([SharedPreferencesStorage])
void main() {
  late AbstractStorage storage;
  late AbstractAuctionLocalDatasource datasource;

  storage = MockSharedPreferencesStorage();
  datasource = AuctionLocalDatasource(storage);

  final List<Map<String, dynamic>> searchByVinTestCases = [
    {
      'description': 'Get AuctionModel From Cache',
      'vin': 'HGT123456789MNSET',
      'cachedValue': json.decode(fixture('auction.json')),
      'expectedResult': AuctionModel.fromJson(json.decode(fixture('auction.json'))),
      'expectedError': false,
      'error': null,
    },
    {
      'description': 'Get Null AuctionModel From Cache',
      'vin': 'HGT123456789MNSET',
      'cachedValue': null,
      'expectedResult': null,
      'expectedError': true,
      'error': null,
    },
  ];

  group('SearchByVin Test', () {
    for (var testCase in searchByVinTestCases) {
      final vin = testCase['vin'];
      final cachedValue = testCase['cachedValue'];
      final description = testCase['description'];
      final expectedResult = testCase['expectedResult'];
      final expectedError = testCase['expectedError'];
      final error = testCase['error'];

      test(description, () async {
        // Mock the searchByVin method in the MockAuctionRemoteDatasource
        if (expectedError) {
          when(storage.read(StorageKey.cachedAuction)).thenAnswer((_) async => null);
        } else {
          when(
            storage.read(StorageKey.cachedAuction),
          ).thenAnswer((_) async => cachedValue != null ? jsonEncode({vin: cachedValue}) : null);
        }

        // Call the method and verify the expectations
        try {
          final AuctionModel? result = await datasource.searchByVin(vin);

          verify(datasource.searchByVin(vin));

          expect(result, expectedResult);
        } catch (e) {
          if (!expectedError || e.toString() != error.toString()) {
            rethrow;
          }
          verify(datasource.searchByVin(vin));
          expect(e, error);
        }
      });
    }
  });
}
