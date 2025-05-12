import 'dart:convert' show jsonDecode, jsonEncode;

import '../../../../../core/storage/abstract_storage.dart' show AbstractStorage;
import '../../../../../core/storage/index.dart' show StorageKey;
import '../../models/auction_model.dart';
import 'abstract_auction_local_datasource.dart' show AbstractAuctionLocalDatasource;

class AuctionLocalDatasource implements AbstractAuctionLocalDatasource {
  final AbstractStorage storage;

  final Map<String, AuctionModel> cachedAuction = {};

  AuctionLocalDatasource(this.storage);

  @override
  Future<bool> cacheAuctionDetails(String vin, AuctionModel auction) async {
    cachedAuction[vin] = auction;
    final jsonString = jsonEncode(cachedAuction.map((key, value) => MapEntry(key, value.toJson())));
    await storage.write(StorageKey.cachedAuction, jsonString);
    return true;
  }

  @override
  Future<AuctionModel?> searchByVin(String vin) async {
    try {
      if (cachedAuction.isEmpty) {
        final jsonString = await storage.read(StorageKey.cachedAuction);
        if (jsonString?.isNotEmpty == true) {
          final decoded = jsonDecode(jsonString!) as Map<String, dynamic>;

          final restoredCache = decoded.map(
            (key, value) => MapEntry(key, AuctionModel.fromJson(value as Map<String, dynamic>)),
          );
          cachedAuction.addAll(restoredCache);
        }
      }
      return cachedAuction[vin];
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> logout() async {
    await storage.clear();
    return true;
  }
}
