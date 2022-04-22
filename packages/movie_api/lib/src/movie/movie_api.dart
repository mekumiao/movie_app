import 'models/models.dart';

abstract class MovieApi {
  const MovieApi();

  Future<MovieDto> get(String id);

  Future<List<MovieDto>> getList({int? no, int? size, MovieQueryParameter? queryParameter});

  Future<int> getTotal(MovieQueryParameter? queryParameter);

  Future<int> star(String id, bool isStar);

  Future<int> dislike(String id, bool isDislike);

  Future<int> update(String id, MovieUpdate movie);

  Future<int> delete(String id);
}
