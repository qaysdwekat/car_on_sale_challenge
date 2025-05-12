import 'package:get_it/get_it.dart';

import '../environments/config/config.dart';
import '../features/auction/data/datasources/index.dart'
    show
        AbstractAuctionRemoteDatasource,
        AuctionRemoteDatasource,
        AbstractAuctionLocalDatasource,
        AuctionLocalDatasource;
import '../features/auction/data/repositories/auction_repository.dart';
import '../features/auction/domain/repositories/index.dart' show AbstractAuctionRepository;
import '../features/auction/domain/usecases/index.dart';
import '../features/auction/presentation/bloc/auction_bloc.dart';
import '../features/auth/data/datasources/index.dart' show AuthDatasource, AbstractAuthDatasource;
import '../features/auth/data/repositories/auth_repository.dart';
import '../features/auth/domain/repositories/index.dart' show AbstractAuthRepository;
import '../features/auth/domain/usecases/index.dart' show LoginUsecase, GetUserInfoUsecase;
import '../features/auth/presentation/bloc/auth_bloc.dart';
import 'cos_challenge.dart';
import 'network/abstract_http_network.dart';
import 'network/abstract_network_config_provider.dart';
import 'network/cos_network_config_provider.dart';
import 'network/http_client.dart';
import 'storage/index.dart' show AbstractStorage, SharedPreferencesStorage;

final dInstance = GetIt.instance;

Future<void> init() async {
  dInstance.registerSingletonAsync<AbstractStorage>(() async {
    final storage = SharedPreferencesStorage();
    await storage.init();
    return storage;
  });

  await dInstance.isReady<AbstractStorage>();

  dInstance.registerSingleton<AbstractNetworkConfigProvider>(CosNetworkConfigProvider(dInstance.call()));

  dInstance.registerSingleton(CosChallenge.httpClient);

  final baseUrl = Config().baseUrl ?? '';
  dInstance.registerSingleton<AbstractHttpNetwork>(CosHttpClient(baseUrl, dInstance.call(), dInstance.call()));

  dInstance.registerSingleton<AbstractAuthDatasource>(AuthDatasource(dInstance.call()));

  dInstance.registerSingleton<AbstractAuthRepository>(AuthRepository(dInstance.call()));

  dInstance.registerFactory(() => LoginUsecase(dInstance.call()));
  dInstance.registerFactory(() => GetUserInfoUsecase(dInstance.call()));
  dInstance.registerFactory(() => AuthBloc(dInstance.call(), dInstance.call()));

  dInstance.registerSingleton<AbstractAuctionRemoteDatasource>(
    AuctionRemoteDatasource(dInstance.call(), dInstance.call()),
  );

  dInstance.registerSingleton<AbstractAuctionLocalDatasource>(AuctionLocalDatasource(dInstance.call()));

  dInstance.registerSingleton<AbstractAuctionRepository>(AuctionRepository(dInstance.call(), dInstance.call()));

  dInstance.registerFactory(() => SearchByVinUsecase(dInstance.call()));
  dInstance.registerFactory(() => LogoutUsecase(dInstance.call()));
  dInstance.registerFactory(() => AuctionBloc(dInstance.call(), dInstance.call()));

  await dInstance.allReady();
}
