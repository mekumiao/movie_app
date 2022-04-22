import 'package:movie_api/src/movie_file/models/movie_file_dto.dart';

abstract class MovieFileApi {
  Future<MovieFileDto> get(String id);

  Future<List<MovieFileDto>> getList({
    int? no,
    int? size,
    String? q,
    Map<String, dynamic> parameters = const {},
  });
}
