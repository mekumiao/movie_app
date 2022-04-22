import 'package:movie_api/movie_api.dart';

class MovieRepository {
  const MovieRepository({
    required MovieApi movieApi,
    required MovieFileApi movieFileApi,
    required MovieTypeApi movieTypeApi,
    required FileApi fileApi,
  })  : _movieApi = movieApi,
        _movieTypeApi = movieTypeApi,
        _fileApi = fileApi;

  final MovieApi _movieApi;
  final MovieTypeApi _movieTypeApi;
  final FileApi _fileApi;

  Future<MovieDto> get(String id) {
    return _movieApi.get(id);
  }

  Future<int> getTotal(MovieQueryParameter? queryParameter) {
    return _movieApi.getTotal(queryParameter);
  }

  Future<List<MovieDto>> getList({int? no, int? size, MovieQueryParameter? queryParameter}) {
    return _movieApi.getList(no: no, size: size, queryParameter: queryParameter);
  }

  Future<List<MovieTypeDto>> getAllTypes() {
    return _movieTypeApi.getList(size: 100);
  }

  Future<void> dislike(String id, bool isDislike) {
    return _movieApi.dislike(id, isDislike);
  }

  Future<void> star(String id, bool isStar) {
    return _movieApi.star(id, isStar);
  }

  Future<int> update(String id, MovieUpdate update, {String? filePath}) async {
    if (filePath?.isNotEmpty == true) {
      final fileId = await _fileApi.add(filePath!);
      update = update.copyWith(pictureFileId: fileId);
    }
    return _movieApi.update(id, update);
  }

  Future<int> delete(String id) {
    return _movieApi.delete(id);
  }
}
