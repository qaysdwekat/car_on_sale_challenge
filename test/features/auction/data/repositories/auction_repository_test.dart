import 'dart:convert' show json;

import 'package:car_on_sale_challenge/core/exceptions/index.dart' show ServerException;
import 'package:car_on_sale_challenge/core/usecases/usecase_value.dart';
import 'package:car_on_sale_challenge/features/auction/data/datasources/index.dart'
    show AbstractAuctionLocalDatasource, AbstractAuctionRemoteDatasource;
import 'package:car_on_sale_challenge/features/auction/data/models/auction_model.dart';
import 'package:car_on_sale_challenge/features/auction/data/repositories/auction_repository.dart';
import 'package:car_on_sale_challenge/features/auction/domain/entities/auction.dart';
import 'package:car_on_sale_challenge/features/auction/domain/repositories/abstract_auction_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'auction_repository_test.mocks.dart';

class AuctionRemoteDatasource extends Mock implements AbstractAuctionRemoteDatasource {}

class AuctionLocalDatasource extends Mock implements AbstractAuctionLocalDatasource {}

@GenerateMocks([AuctionRemoteDatasource, AuctionLocalDatasource])
void main() {
  late AbstractAuctionRemoteDatasource remoteDatasource;
  late AbstractAuctionLocalDatasource localDatasource;
  late AbstractAuctionRepository repository;

  setUp(() {
    remoteDatasource = MockAuctionRemoteDatasource();
    localDatasource = MockAuctionLocalDatasource();

    repository = AuctionRepository(remoteDatasource, localDatasource);
  });

  final List<Map<String, dynamic>> searchByVinTestCases = [
    {
      'description': 'Successful Get AuctionModel By Vin',
      'vin': 'HGT123456789MNSET',
      'expectedResult': AuctionModel.fromJson(json.decode(fixture('auction.json'))),
      'expectedError': false,
      'error': null,
    },
    {
      'description': 'Get ServerException',
      'vin': 'HGT123456789MNSET',
      'expectedResult': null,
      'expectedError': true,
      'error': ServerException(message: 'Something went wrong'),
    },
  ];

  group('SearchByVin Test', () {
    for (var testCase in searchByVinTestCases) {
      final vin = testCase['vin'];
      final description = testCase['description'];
      final expectedResult = testCase['expectedResult'];
      final expectedError = testCase['expectedError'];
      final error = testCase['error'];

      test(description, () async {
        // Mock the searchByVin method in the MockAuctionRemoteDatasource
        if (expectedError) {
          when(remoteDatasource.searchByVin(vin)).thenThrow(error);
          when(localDatasource.searchByVin(vin)).thenAnswer((_) async => null);
        } else {
          when(localDatasource.cacheAuctionDetails(vin, expectedResult)).thenAnswer((_) async => true);
          when(localDatasource.searchByVin(vin)).thenAnswer((_) async => null);
          when(remoteDatasource.searchByVin(vin)).thenAnswer((_) async => expectedResult);
        }

        // Call the method and verify the expectations
        try {
          final UsecaseValue<Auction> result = await repository.searchByVin(vin);

          verify(repository.searchByVin(vin));

          switch (result) {
            case UsecaseSuccess():
              expect(result.result, expectedResult);
            case AppFailureException():
              expect(result.exception, error);
          }
        } catch (e) {
          if (!expectedError || e.toString() != error.toString()) {
            rethrow;
          }
          verify(repository.searchByVin(vin));
          expect(e, error);
        }
      });
    }
  });
}
