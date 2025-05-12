import '../cos_challenge.dart' show CosChallenge;
import '../storage/index.dart' show AbstractStorage, StorageKey;
import 'abstract_network_config_provider.dart';

class CosNetworkConfigProvider implements AbstractNetworkConfigProvider {
  final AbstractStorage storage;

  CosNetworkConfigProvider(this.storage);
  @override
  Future<Map<String, String>> getHeaders() async {
    final user = await storage.read(StorageKey.username);
    return {CosChallenge.user: user ?? ''};
  }
}
