import 'package:get_it/get_it.dart';

// import '../core/network/abstract_http_network.dart';
// import '../core/network/abstract_network_config_provider.dart';
// import '../environments/config/config.dart';

final dInstance = GetIt.instance;

Future<void> init() async {
  // dInstance.registerSingleton<AbstractNetworkConfigProvider>(DioNetworkConfigProvider());

  // final clinet = DioHttpNetwork(baseUrl: Config().baseUrl, configProvider: dInstance.call());
}
