import '../../../../core/usecases/usecase_value.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/exceptions/index.dart';
import '../../domain/entities/auction.dart';
import '../../domain/repositories/abstract_auction_repository.dart';
import '../datasources/index.dart' show AbstractAuctionRemoteDatasource, AbstractAuctionLocalDatasource;

class AuctionRepository implements AbstractAuctionRepository {
  final AbstractAuctionRemoteDatasource remoteDatasource;
  final AbstractAuctionLocalDatasource localDatasource;

  AuctionRepository(this.remoteDatasource, this.localDatasource);

  @override
  Future<UsecaseValue<Auction>> searchByVin(String vin) async {
    try {
      final response = await remoteDatasource.searchByVin(vin);
      await localDatasource.cacheAuctionDetails(vin, response);
      return UsecaseValue.success(response);
    } on MultipleChoicesException catch (e) {
      return UsecaseValue.exception(e);
    } on AppException catch (e) {
      final cached = await localDatasource.searchByVin(vin);
      if (cached != null) return UsecaseValue.success(cached);
      return UsecaseValue.exception(e);
    } catch (e) {
      final cached = await localDatasource.searchByVin(vin);
      if (cached != null) return UsecaseValue.success(cached);
      return UsecaseValue.exception(GeneralException());
    }
  }

  @override
  Future<UsecaseValue<bool>> logout() async {
    await localDatasource.logout();
    return UsecaseValue.success(true);
  }
}
