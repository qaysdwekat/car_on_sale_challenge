import 'dart:async';

import 'package:car_on_sale_challenge/features/auction/domain/entities/auction.dart';

import '../../../../core/usecases/single_usecase_with_parameter.dart';
import '../../../../core/usecases/usecase_value.dart';
import '../repositories/abstract_auction_repository.dart';

class SearchByVinUsecase implements SingleUsecaseWithParameter<Auction, String> {
  final AbstractAuctionRepository repo;
  const SearchByVinUsecase(this.repo);
  @override
  FutureOr<UsecaseValue<Auction>> call(String data) {
    return repo.searchByVin(data);
  }
}
