import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_api/movie_api.dart';
import 'package:movie_repository/movie_repository.dart';

part 'movie_edit_state.dart';

class MovieEditCubit extends Cubit<MovieEditState> {
  MovieEditCubit({
    required String id,
    required MovieDto movie,
    required MovieRepository movieRepository,
  })  : _movieRepository = movieRepository,
        super(MovieEditState(
          id: id,
          picturePath: movie.pictureURL,
          movie: movie,
          update: MovieUpdate(
            actorName: movie.actorName,
            remark: movie.remark,
          ),
        ));

  final MovieRepository _movieRepository;

  Future<void> submit() async {
    try {
      emit(state.copyWith(status: MovieEditStatus.submissionInProgress));
      await _movieRepository.update(state.id, state.update, filePath: state.picturePath);
      emit(state.copyWith(status: MovieEditStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(status: MovieEditStatus.submissionFailure));
    }
  }

  void actorNameChange(String actorName) {
    emit(state.copyWith(movie: state.movie.copyWith(actorName: actorName)));
  }

  void remarkChange(String remark) {
    emit(state.copyWith(movie: state.movie.copyWith(remark: remark)));
  }

  void pictureChange(String picture) {
    emit(state.copyWith(picturePath: picture));
  }
}
