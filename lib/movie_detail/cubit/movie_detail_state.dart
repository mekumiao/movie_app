part of 'movie_detail_cubit.dart';

enum MoviePlayStatus {
  stopped,
  played,
  failure,
}

class MovieDetailState extends Equatable {
  const MovieDetailState({
    this.playStatus = MoviePlayStatus.stopped,
    this.isDislike = false,
    this.isStar = false,
    this.movie = const MovieDto(),
  });

  final MoviePlayStatus playStatus;
  final MovieDto movie;
  final bool isDislike;
  final bool isStar;

  MovieDetailState copyWith({
    bool? isDislike,
    bool? isStar,
    MoviePlayStatus? playStatus,
    MovieDto? movie,
  }) {
    return MovieDetailState(
      playStatus: playStatus ?? this.playStatus,
      isDislike: isDislike ?? this.isDislike,
      isStar: isStar ?? this.isStar,
      movie: movie ?? this.movie,
    );
  }

  @override
  List<Object> get props => [playStatus, movie, isDislike, isStar];
}
