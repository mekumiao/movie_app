part of 'search_movie_bloc.dart';

@JsonSerializable()
class SearchMovieState extends Equatable {
  const SearchMovieState({
    this.q = '',
    this.parameters = const {},
    this.allowDelete = false,
    this.histories = const [],
    this.types = const {},
    this.movieTypeId = '',
  });

  factory SearchMovieState.fromJson(Map<String, dynamic> json) => _$SearchMovieStateFromJson(json);
  Map<String, dynamic> toJson() => _$SearchMovieStateToJson(this);

  final String q;
  final bool allowDelete;
  final Map<String, dynamic> parameters;
  final List<String> histories;
  final Map<String, String> types;
  final String movieTypeId;

  SearchMovieState copyWith({
    String? tag,
    String? q,
    String? movieTypeId,
    List<String>? histories,
    Map<String, String>? types,
    Map<String, dynamic>? parameters,
    bool? allowDelete,
  }) {
    return SearchMovieState(
      q: q ?? this.q,
      histories: histories ?? this.histories,
      types: types ?? this.types,
      movieTypeId: movieTypeId ?? this.movieTypeId,
      allowDelete: allowDelete ?? this.allowDelete,
      parameters: parameters ?? this.parameters,
    );
  }

  @override
  List<Object> get props => [q, histories, allowDelete, parameters, types, movieTypeId];
}
