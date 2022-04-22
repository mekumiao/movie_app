import 'package:design/design.dart';
import 'package:movie_api/movie_api.dart';

class ActorRepositroy {
  const ActorRepositroy({
    required ActorApi actorApi,
  }) : _actorApi = actorApi;

  final ActorApi _actorApi;

  Future<ActorDto> getActor(String id) {
    return _actorApi.get(id);
  }

  Future<List<ActorDto>> getActors({
    String? q,
    int? no,
  }) {
    return _actorApi.getList(
      q: q,
      no: no,
      size: Constant.limitSize,
    );
  }

  Future<List<ActorDto>> getAllActor({
    String? q,
    int? no,
  }) {
    return _actorApi.getList(
      q: q,
      no: no,
      size: 100,
    );
  }
}
