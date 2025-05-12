import 'package:bloc/bloc.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/usecases/usecase_value.dart';
import '../../domain/entities/vehicle.dart';
import '../../domain/usecases/index.dart' show LogoutUsecase, SearchByVinUsecase;
import 'auction_state.dart';
import 'events/abstract_auction_event.dart';
import 'events/logout_event.dart';
import 'events/search_by_vin_event.dart';

class AuctionBloc extends Bloc<AbstractAuctionEvent, AuctionState> {
  AuctionBloc(SearchByVinUsecase searchByVinUsecase, LogoutUsecase logoutUsecase) : super(InitialState()) {
    on<SearchByVinEvent>((event, emit) async {
      emit(LoadingState(eventType: event.runtimeType));
      final response = await searchByVinUsecase(event.vin);
      switch (response) {
        case UsecaseSuccess():
          final info = response.result;
          emit(AuctionDetailsState(eventType: event.runtimeType, details: info));
        case AppFailureException():
          final exception = response.exception;
          switch (exception) {
            case UnauthorizedException():
              emit(SessionExpiredState());
              break;
            case MultipleChoicesException<List<Vehicle>>():
              final vehicles = exception.data..sort((a, b) => (b.similarity ?? 0).compareTo(a.similarity ?? 0));
              emit(MultipleChoicesState(vehicles));
              break;
            default:
              emit(ErrorState(eventType: event.runtimeType, error: exception.message, vin: event.vin));
              break;
          }
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(SessionExpiredState());
    });
  }
}
