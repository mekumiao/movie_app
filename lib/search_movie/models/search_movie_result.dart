import 'package:movie_api/movie_api.dart';

class SearchMovieResult {
  const SearchMovieResult({
    this.isSearch = false,
    this.queryParameter = const MovieQueryParameter(),
  });

  final bool isSearch;
  final MovieQueryParameter queryParameter;
}
