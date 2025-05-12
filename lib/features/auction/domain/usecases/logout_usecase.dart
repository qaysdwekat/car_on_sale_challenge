import 'dart:async';

import '../../../../core/usecases/single_usecase.dart';
import '../../../../core/usecases/usecase_value.dart';
import '../repositories/abstract_auction_repository.dart';

class LogoutUsecase implements SingleUsecase<bool> {
  final AbstractAuctionRepository repo;
  const LogoutUsecase(this.repo);
  @override
  FutureOr<UsecaseValue<bool>> call() {
    return repo.logout();
  }
}
