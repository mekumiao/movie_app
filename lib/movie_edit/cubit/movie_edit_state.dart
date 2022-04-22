part of 'movie_edit_cubit.dart';

enum MovieEditStatus { pure, submissionInProgress, submissionSuccess, submissionFailure }

class MovieEditState extends Equatable {
  const MovieEditState({
    this.status = MovieEditStatus.pure,
    this.movie = const MovieDto(),
    this.update = const MovieUpdate(),
    this.id = '',
    this.picturePath = '',
  });

  final String picturePath;
  final MovieEditStatus status;
  final MovieDto movie;
  final MovieUpdate update;
  final String id;

  MovieEditState copyWith({
    MovieEditStatus? status,
    MovieDto? movie,
    MovieUpdate? update,
    String? id,
    String? picturePath,
  }) {
    return MovieEditState(
      status: status ?? this.status,
      movie: movie ?? this.movie,
      update: update ?? this.update,
      id: id ?? this.id,
      picturePath: picturePath ?? this.picturePath,
    );
  }

  @override
  List<Object> get props => [status, movie, id, picturePath, update];
}
