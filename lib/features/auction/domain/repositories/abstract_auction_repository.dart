import '../../../../core/usecases/usecase_value.dart';
import '../entities/auction.dart';

abstract class AbstractAuctionRepository {
  Future<UsecaseValue<Auction>> searchByVin(String vin);
  Future<UsecaseValue<bool>> logout();
}
