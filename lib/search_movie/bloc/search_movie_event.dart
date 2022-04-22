part of 'search_movie_bloc.dart';

abstract class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();

  @override
  List<Object> get props => [];
}

class SearchHistoryChanged extends SearchMovieEvent {
  const SearchHistoryChanged();
}

class SearchHistoryDeleted extends SearchMovieEvent {
  const SearchHistoryDeleted({required this.q});

  final String q;

  @override
  List<Object> get props => [q];
}

class SearchHistoryCleared extends SearchMovieEvent {
  const SearchHistoryCleared();
}

class SearchHistorySynced extends SearchMovieEvent {
  const SearchHistorySynced();
}

class SearchAllowDeleteSwitched extends SearchMovieEvent {
  const SearchAllowDeleteSwitched();
}

class SearchParameterChanged extends SearchMovieEvent {
  const SearchParameterChanged({
    required this.key,
    required this.value,
  });

  final String key;
  final dynamic value;

  @override
  List<Object> get props => [key, value.toString()];
}

class SearchQChanged extends SearchMovieEvent {
  const SearchQChanged({required this.q});

  final String q;

  @override
  List<Object> get props => [q];
}

class MovieTypeReLoaded extends SearchMovieEvent {
  const MovieTypeReLoaded();
}

class MovieTypeChanged extends SearchMovieEvent {
  const MovieTypeChanged({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}
