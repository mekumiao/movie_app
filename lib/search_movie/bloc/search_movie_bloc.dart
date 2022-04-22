import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:utils/util.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';
part 'search_movie_bloc.g.dart';

class SearchMovieBloc extends HydratedBloc<SearchMovieEvent, SearchMovieState> {
  SearchMovieBloc({
    required this.movieRepository,
    required this.searchHistoryRepository,
  }) : super(const SearchMovieState()) {
    on<SearchQChanged>(_onSearchQChanged);
    on<SearchHistoryChanged>(_onSearchHistoryChanged);
    on<SearchAllowDeleteSwitched>(_onSearchAllowDeleteSwitched);
    on<SearchHistoryDeleted>(_onSearchHistoryDeleted);
    on<SearchHistoryCleared>(_onSearchHistoryCleared);
    on<SearchParameterChanged>(_onSearchParameterChanged);
    on<MovieTypeReLoaded>(_onMovieTypeReLoaded);
    on<MovieTypeChanged>(_onMovieTypeChanged);
    on<SearchHistorySynced>(_onSearchHistorySynced);
  }

  final MovieRepository movieRepository;
  final SearchHistoryRepository searchHistoryRepository;

  static const limit = 15;

  void _onSearchQChanged(
    SearchQChanged event,
    Emitter<SearchMovieState> emit,
  ) {
    emit(state.copyWith(q: event.q));
  }

  void _onSearchHistoryChanged(
    SearchHistoryChanged event,
    Emitter<SearchMovieState> emit,
  ) {
    if (state.q.isNotEmpty) {
      final histories = List.of(state.histories)..removeWhere((element) => element == state.q);
      histories.insert(0, state.q);
      if (histories.length > limit) {
        histories.removeAt(histories.length - 1);
      }
      emit(state.copyWith(histories: histories));
    }
    emit(state);
  }

  void _onSearchAllowDeleteSwitched(
    SearchAllowDeleteSwitched event,
    Emitter<SearchMovieState> emit,
  ) {
    emit(state.copyWith(allowDelete: !state.allowDelete));
  }

  Future<void> _onSearchHistoryDeleted(
    SearchHistoryDeleted event,
    Emitter<SearchMovieState> emit,
  ) async {
    try {
      final histories = List.of(state.histories)..removeWhere((element) => element == event.q);
      emit(state.copyWith(histories: histories));
      await searchHistoryRepository.deleteMovieSearchHistories(event.q);
    } catch (e) {
      emit(state);
      showToast(e.toString());
    }
  }

  void _onSearchHistoryCleared(
    SearchHistoryCleared event,
    Emitter<SearchMovieState> emit,
  ) {
    emit(state.copyWith(histories: const []));
  }

  void _onSearchParameterChanged(
    SearchParameterChanged event,
    Emitter<SearchMovieState> emit,
  ) {
    final parameters = Map.of(state.parameters);
    parameters[event.key] = event.value;
    emit(state.copyWith(parameters: parameters));
  }

  Future<void> _onMovieTypeReLoaded(
    MovieTypeReLoaded event,
    Emitter<SearchMovieState> emit,
  ) async {
    final types = await movieRepository.getAllTypes();
    final typeMap = Map.fromEntries(types.map((e) => MapEntry(e.id, e.name)));
    emit(state.copyWith(types: typeMap));
  }

  void _onMovieTypeChanged(
    MovieTypeChanged event,
    Emitter<SearchMovieState> emit,
  ) {
    emit(state.copyWith(movieTypeId: event.id));
  }

  Future<void> _onSearchHistorySynced(
    SearchHistorySynced event,
    Emitter<SearchMovieState> emit,
  ) async {
    try {
      final histories = await searchHistoryRepository.getMovieSearchHistories(size: limit);
      final items = histories.map((e) => e.value).toList();
      emit(state.copyWith(histories: items));
    } catch (e) {
      emit(state);
      showToast(e.toString());
    }
  }

  @override
  SearchMovieState? fromJson(Map<String, dynamic> json) => SearchMovieState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(SearchMovieState state) => state.toJson();
}
