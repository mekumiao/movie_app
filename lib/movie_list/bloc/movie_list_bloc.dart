import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:design/design.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:movie_api/movie_api.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:utils/util.dart';

part 'movie_list_event.dart';
part 'movie_state_state.dart';

EventTransformer<E> throttleDroppable<E>() {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(const Duration(milliseconds: 300)), mapper);
  };
}

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  MovieListBloc({
    required MovieRepository movieRepository,
  })  : _movieRepository = movieRepository,
        super(const MovieListState()) {
    on<MovieListFetched>(_onMovieListFetched, transformer: throttleDroppable());
    on<MovieListRefreshed>(_onMovieListRefreshed, transformer: throttleDroppable());
    on<MovieListQueryParameterChanged>(_onMovieListParameteChanged);
    on<MovieListItemChanged>(_onMovieListItemChanged);
    on<MoiveListItemDeleted>(_onMoiveListItemDeleted);
    on<MovieListTotalRefreshed>(_onMovieListTotalRefreshed, transformer: throttleDroppable());
    on<MovieListTitleChanged>(_onMovieListTitleChanged);
  }

  final MovieRepository _movieRepository;

  Future<void> _onMovieListFetched(
    MovieListFetched event,
    Emitter<MovieListState> emit,
  ) async {
    if (state.hasReachedMax) {
      emit(state.copyWith(status: MovieListStatus.loaded));
      return;
    }
    try {
      emit(state.copyWith(status: MovieListStatus.loading));
      final no = state.no + 1;
      final movies = await _movieRepository.getList(
        no: no,
        size: Constant.limitSize,
        queryParameter: state.queryParameter,
      );
      movies.isEmpty
          ? emit(state.copyWith(
              no: no,
              status: MovieListStatus.loaded,
              hasReachedMax: true,
            ))
          : emit(state.copyWith(
              no: no,
              status: MovieListStatus.loaded,
              movies: List.of(state.movies)..addAll(movies),
              hasReachedMax: movies.length < Constant.limitSize,
            ));
    } catch (_) {
      emit(state.copyWith(status: MovieListStatus.loadedFailure));
    }
  }

  Future<void> _onMovieListRefreshed(
    MovieListRefreshed event,
    Emitter<MovieListState> emit,
  ) async {
    try {
      emit(state.copyWith(status: MovieListStatus.loading));
      final movies = await _movieRepository.getList(
        no: 1,
        size: Constant.limitSize,
        queryParameter: state.queryParameter,
      );
      emit(state.copyWith(
        no: 1,
        status: MovieListStatus.refreshed,
        hasReachedMax: movies.isEmpty || movies.length < Constant.limitSize,
        movies: movies,
      ));
    } catch (_) {
      emit(state.copyWith(status: MovieListStatus.refreshedFailure));
    }
  }

  void _onMovieListParameteChanged(
    MovieListQueryParameterChanged event,
    Emitter<MovieListState> emit,
  ) {
    emit(state.copyWith(queryParameter: event.queryParameter));
  }

  void _onMovieListItemChanged(
    MovieListItemChanged event,
    Emitter<MovieListState> emit,
  ) {
    emit(state.copyWith(status: MovieListStatus.loading));
    final movies = state.movies
      ..removeAt(event.index)
      ..insert(event.index, event.movie);
    emit(state.copyWith(movies: movies, status: MovieListStatus.changed));
  }

  Future<void> _onMoiveListItemDeleted(
    MoiveListItemDeleted event,
    Emitter<MovieListState> emit,
  ) async {
    try {
      emit(state.copyWith(status: MovieListStatus.loading));
      await _movieRepository.delete(event.id);
      final movies = state.movies..removeAt(event.index);
      final total = state.total - 1;
      emit(state.copyWith(
        movies: movies,
        total: total > 0 ? total : 0,
        status: MovieListStatus.deleted,
      ));
    } catch (e) {
      showToast(e.toString());
      emit(state.copyWith(status: MovieListStatus.failure));
    }
  }

  Future<void> _onMovieListTotalRefreshed(
    MovieListTotalRefreshed event,
    Emitter<MovieListState> emit,
  ) async {
    try {
      emit(state.copyWith(status: MovieListStatus.loading));
      final total = await _movieRepository.getTotal(state.queryParameter);
      emit(state.copyWith(total: total, status: MovieListStatus.totalRefreshed));
    } catch (e) {
      emit(state.copyWith(status: MovieListStatus.failure));
    }
  }

  void _onMovieListTitleChanged(
    MovieListTitleChanged event,
    Emitter<MovieListState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }
}
