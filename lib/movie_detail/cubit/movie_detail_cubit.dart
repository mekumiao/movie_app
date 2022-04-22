import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_api/movie_api.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:utils/util.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit({
    required MovieDto movie,
    required this.movieRepository,
  }) : super(MovieDetailState(
          movie: movie,
          isStar: movie.isStar,
          isDislike: movie.isDislike,
        ));

  final MovieRepository movieRepository;

  void play() {
    emit(state.copyWith(playStatus: MoviePlayStatus.played));
  }

  void stop() {
    emit(state.copyWith(playStatus: MoviePlayStatus.stopped));
  }

  Future<void> switchDislike() async {
    try {
      final isDislike = !state.isDislike;
      await movieRepository.dislike(state.movie.id, isDislike);
      emit(state.copyWith(
        isDislike: isDislike,
        movie: state.movie.copyWith(isDislike: isDislike),
      ));
    } catch (e) {
      emit(state);
      showToast(e.toString());
    }
  }

  Future<void> switchStar() async {
    try {
      final isStart = !state.isStar;
      await movieRepository.star(state.movie.id, isStart);
      emit(state.copyWith(
        isStar: isStart,
        movie: state.movie.copyWith(isStar: isStart),
      ));
    } catch (e) {
      emit(state);
      showToast(e.toString());
    }
  }
}
