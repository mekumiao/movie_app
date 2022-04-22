import 'package:movie_api/src/actor/models/actor_dto.dart';

abstract class ActorApi {
  Future<String> add({
    required String name,
    required String remark,
    String? picturePath,
  });

  Future<int> update(
    String id, {
    required String name,
    required String remark,
    String? picturePath,
  });

  Future<int> delete(String id);

  Future<ActorDto> get(String id);

  Future<List<ActorDto>> getList({
    String? q,
    int? no,
    int? size,
    String? sorting,
  });
}
