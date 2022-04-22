part of 'movie_list_bloc.dart';

enum MovieListStatus {
  initial,
  loading,
  refreshed,
  refreshedFailure,
  loaded,
  loadedFailure,
  deleted,
  changed,
  totalRefreshed,
  failure,
}

class MovieListState extends Equatable {
  const MovieListState({
    this.no = 1,
    this.title = '',
    this.total = 0,
    this.queryParameter = const MovieQueryParameter(),
    this.movies = const <MovieDto>[],
    this.hasReachedMax = false,
    this.status = MovieListStatus.initial,
  });

  final int no;
  final String title;
  final int total;
  final MovieQueryParameter queryParameter;
  final List<MovieDto> movies;
  final bool hasReachedMax;
  final MovieListStatus status;

  MovieListState copyWith({
    int? no,
    String? title,
    int? total,
    MovieListStatus? status,
    List<MovieDto>? movies,
    MovieQueryParameter? queryParameter,
    String? movieTypeId,
    String? actorId,
    bool? hasReachedMax,
  }) {
    return MovieListState(
      no: no ?? this.no,
      title: title ?? this.title,
      total: total ?? this.total,
      status: status ?? this.status,
      movies: movies ?? this.movies,
      queryParameter: queryParameter ?? this.queryParameter,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [no, title, movies, hasReachedMax, status, queryParameter, total];
}
