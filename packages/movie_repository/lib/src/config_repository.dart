import 'package:movie_api/movie_api.dart';

class ConfigRepository {
  const ConfigRepository({
    required HostConfigApi hostConfigApi,
  }) : _hostConfigApi = hostConfigApi;

  final HostConfigApi _hostConfigApi;

  Future<List<HostConfigDto>> getAllHostConfigs() async {
    final configs = await _hostConfigApi.getList(size: 100);
    return configs;
  }
}
