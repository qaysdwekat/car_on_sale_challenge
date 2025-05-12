import 'package:car_on_sale_challenge/core/exceptions/index.dart';
import 'package:car_on_sale_challenge/core/storage/index.dart';

import '../../../../../core/network/abstract_http_network.dart';
import '../../models/auction_model.dart';
import '../../models/vehicle_model.dart';
import 'abstract_auction_remote_datasource.dart' show AbstractAuctionRemoteDatasource;

class AuctionRemoteDatasource implements AbstractAuctionRemoteDatasource {
  final AbstractHttpNetwork httpClinet;
  final AbstractStorage storage;

  AuctionRemoteDatasource(this.httpClinet, this.storage);

  @override
  Future<AuctionModel> searchByVin(String vin) async {
    try {
      final response = await httpClinet.makeGetRequest('path');
      final data = response.getData();
      final auction = AuctionModel.fromJson(data);
      return auction;
    } on MultipleChoicesException catch (e) {
      List<VehicleModel> vehicles =
          e.data.map<VehicleModel>((json) => VehicleModel.fromJson(json as Map<String, dynamic>)).toList();
      throw MultipleChoicesException<List<VehicleModel>>(data: vehicles);
    } on UnauthorizedException catch (_) {
      storage.remove(StorageKey.username);
      rethrow;
    } on AppException catch (_) {
      rethrow;
    }
  }
}
