import 'package:car_on_sale_challenge/features/auction/data/models/auction_model.dart';

abstract class AbstractAuctionRemoteDatasource {
  Future<AuctionModel> searchByVin(String vin);
}
