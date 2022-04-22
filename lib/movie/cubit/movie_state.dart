part of 'movie_cubit.dart';

@JsonSerializable()
class MovieState extends Equatable {
  const MovieState({
    this.no = 1,
    this.title = '',
    this.queryParameter = const MovieQueryParameter(),
  });

  factory MovieState.fromJson(Map<String, dynamic> json) => _$MovieStateFromJson(json);

  final int no;
  final String title;
  final MovieQueryParameter queryParameter;

  MovieState copyWith({
    int? no,
    String? title,
    MovieQueryParameter? queryParameter,
  }) {
    return MovieState(
      no: no ?? this.no,
      title: title ?? this.title,
      queryParameter: queryParameter ?? this.queryParameter,
    );
  }

  Map<String, dynamic> toJson() => _$MovieStateToJson(this);

  @override
  List<Object> get props => [no, title, queryParameter];
}
