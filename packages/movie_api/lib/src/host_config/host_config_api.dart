import 'models/models.dart';

abstract class HostConfigApi {
  Future<String> add(HostConfigAdd input);

  Future<int> update(String id, HostConfigUpdate input);

  Future<int> delete(String id);

  Future<HostConfigDto> get(String id);

  Future<List<HostConfigDto>> getList({
    String? q,
    int? no,
    int? size,
    String? sorting,
  });
}
