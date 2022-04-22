import 'package:movie_api/movie_api.dart';

class SearchHistoryRepository {
  const SearchHistoryRepository({
    required UserSearchHistoryApi userSearchHistoryApi,
  }) : _userSearchHistoryApi = userSearchHistoryApi;

  final UserSearchHistoryApi _userSearchHistoryApi;

  Future<List<UserSearchHistoryDto>> getMovieSearchHistories({
    int? no,
    int? size,
  }) {
    return _userSearchHistoryApi.getList(
      distinct: true,
      tag: 'movie',
      no: no,
      size: size,
    );
  }

  Future<int> deleteMovieSearchHistories(String vlaue) {
    return _userSearchHistoryApi.delete('movie', value: vlaue);
  }
}
