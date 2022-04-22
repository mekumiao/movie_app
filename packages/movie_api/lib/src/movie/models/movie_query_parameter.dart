import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_query_parameter.g.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class MovieQueryParameter extends Equatable {
  const MovieQueryParameter({
    this.site,
    this.actorId,
    this.movieTypeId,
    this.isDislike,
    this.isStar,
    this.hasPicture,
    this.hasMovieFile,
    this.distinct,
    this.q,
    this.sorting,
  });

  factory MovieQueryParameter.fromJson(Map<String, dynamic> json) => _$MovieQueryParameterFromJson(json);

  final int? site;
  final String? actorId;
  final String? movieTypeId;
  final bool? isDislike;
  final bool? isStar;
  final bool? hasPicture;
  final bool? hasMovieFile;
  final bool? distinct;
  final String? q;
  final String? sorting;

  Map<String, dynamic> toJson() => _$MovieQueryParameterToJson(this);

  MovieQueryParameter copyWith({
    int? site,
    String? actorId,
    String? movieTypeId,
    bool? isDislike,
    bool? isStar,
    bool? hasPicture,
    bool? hasMovieFile,
    bool? hasTotal,
    bool? distinct,
    String? q,
    String? sorting,
  }) {
    return MovieQueryParameter(
      site: site ?? this.site,
      actorId: actorId ?? this.actorId,
      movieTypeId: movieTypeId ?? this.movieTypeId,
      isDislike: isDislike ?? this.isDislike,
      isStar: isStar ?? this.isStar,
      hasPicture: hasPicture ?? this.hasPicture,
      hasMovieFile: hasMovieFile ?? this.hasMovieFile,
      distinct: distinct ?? this.distinct,
      q: q ?? this.q,
      sorting: sorting ?? this.sorting,
    );
  }

  @override
  List<Object?> get props => [
        site,
        actorId,
        movieTypeId,
        isDislike,
        isStar,
        hasPicture,
        hasMovieFile,
        distinct,
        q,
        sorting,
      ];
}
