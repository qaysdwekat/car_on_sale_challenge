import '../../models/auction_model.dart';

abstract class AbstractAuctionLocalDatasource {
  Future<AuctionModel?> searchByVin(String vin);
  Future<bool> cacheAuctionDetails(String vin, AuctionModel auction);
  Future<bool> logout();
}
