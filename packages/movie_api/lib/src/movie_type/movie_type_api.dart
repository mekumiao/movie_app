import 'models/models.dart';

abstract class MovieTypeApi {
  Future<MovieTypeDto> get(String id);

  Future<List<MovieTypeDto>> getList({
    int? no,
    int? size,
    String? q,
    Map<String, dynamic> parameters = const {},
  });
}
