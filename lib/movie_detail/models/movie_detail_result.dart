import 'package:movie_api/movie_api.dart';

class MovieDetailResult {
  const MovieDetailResult({
    required this.index,
    required this.movie,
  });

  final int index;
  final MovieDto movie;
}
