import 'package:bloc_test/bloc_test.dart';
import 'package:car_on_sale_challenge/core/usecases/usecase_value.dart' show UsecaseValue;
import 'package:car_on_sale_challenge/features/auction/domain/entities/auction.dart';
import 'package:car_on_sale_challenge/features/auction/domain/usecases/index.dart'
    show SearchByVinUsecase, LogoutUsecase;
import 'package:car_on_sale_challenge/features/auction/presentation/bloc/auction_bloc.dart';
import 'package:car_on_sale_challenge/features/auction/presentation/bloc/auction_state.dart';
import 'package:car_on_sale_challenge/features/auction/presentation/bloc/events/search_by_vin_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchByVinUsecase extends Mock implements SearchByVinUsecase {}

class MockLogoutUsecase extends Mock implements LogoutUsecase {}

void main() {
  late SearchByVinUsecase searchByVinUsecase;
  late LogoutUsecase logoutUsecase;
  late AuctionBloc bloc;

  setUp(() {
    searchByVinUsecase = MockSearchByVinUsecase();
    logoutUsecase = MockLogoutUsecase();
    bloc = AuctionBloc(searchByVinUsecase, logoutUsecase);
  });

  group('Get Search Auction Info By VIN Usecase', () {
    final vin = 'HGT123456789MNSET';

    final searchResponse = Auction();

    blocTest<AuctionBloc, AuctionState>(
      'Should emit LoadingState and get data in VehicleData when SearchByVinEvent is added and usecase fetchs data successfully',
      build: () {
        when(() => searchByVinUsecase(vin)).thenAnswer((_) async => UsecaseValue.success(searchResponse));
        return bloc;
      },
      act: (bloc) async {
        bloc.add(SearchByVinEvent(vin));
        await untilCalled(() => searchByVinUsecase(vin));
      },
      expect:
          () => [
            LoadingState(eventType: SearchByVinEvent),
            AuctionDetailsState(eventType: SearchByVinEvent, details: searchResponse),
          ],
    );
  });
}
