import 'package:car_on_sale_challenge/core/usecases/usecase_value.dart';
import 'package:car_on_sale_challenge/features/auction/domain/entities/auction.dart' show Auction;
import 'package:car_on_sale_challenge/features/auction/domain/repositories/index.dart' show AbstractAuctionRepository;
import 'package:car_on_sale_challenge/features/auction/domain/usecases/index.dart' show SearchByVinUsecase;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuctionRepository extends Mock implements AbstractAuctionRepository {}

void main() {
  late AbstractAuctionRepository repository;
  late SearchByVinUsecase usecase;

  setUp(() {
    repository = MockAuctionRepository();
    usecase = SearchByVinUsecase(repository);
  });

  final vin = 'HGT123456789MNSET';
  final searchResponse = Auction();
  test("Should Search By Vin From The Repository", () async {
    // arrange
    when(() => repository.searchByVin(vin)).thenAnswer((_) async => UsecaseValue.success(searchResponse));

    // act
    final result = await usecase(vin);

    // assert
    expect(result, equals(UsecaseSuccess(searchResponse)));
    verify(() => repository.searchByVin(vin)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
