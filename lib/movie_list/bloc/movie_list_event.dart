part of 'movie_list_bloc.dart';

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();

  @override
  List<Object> get props => [];
}

class MovieListFetched extends MovieListEvent {
  const MovieListFetched();
}

class MovieListTotalRefreshed extends MovieListEvent {
  const MovieListTotalRefreshed();
}

class MovieListRefreshed extends MovieListEvent {
  const MovieListRefreshed();
}

class MovieListQueryParameterChanged extends MovieListEvent {
  const MovieListQueryParameterChanged({
    this.queryParameter = const MovieQueryParameter(),
  });

  final MovieQueryParameter queryParameter;

  @override
  List<Object> get props => [queryParameter];
}

class MovieListItemChanged extends MovieListEvent {
  const MovieListItemChanged({
    required this.index,
    required this.movie,
  });

  final int index;
  final MovieDto movie;

  @override
  List<Object> get props => [index, movie];
}

class MoiveListItemDeleted extends MovieListEvent {
  const MoiveListItemDeleted({
    required this.id,
    required this.index,
  });

  final String id;
  final int index;

  @override
  List<Object> get props => [index, id];
}

class MovieListTitleChanged extends MovieListEvent {
  const MovieListTitleChanged({this.title = ''});

  final String title;

  @override
  List<Object> get props => [title];
}
