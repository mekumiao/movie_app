// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_query_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieQueryParameter _$MovieQueryParameterFromJson(Map<String, dynamic> json) =>
    MovieQueryParameter(
      site: json['site'] as int?,
      actorId: json['actorId'] as String?,
      movieTypeId: json['movieTypeId'] as String?,
      isDislike: json['isDislike'] as bool?,
      isStar: json['isStar'] as bool?,
      hasPicture: json['hasPicture'] as bool?,
      hasMovieFile: json['hasMovieFile'] as bool?,
      distinct: json['distinct'] as bool?,
      q: json['q'] as String?,
      sorting: json['sorting'] as String?,
    );

Map<String, dynamic> _$MovieQueryParameterToJson(
        MovieQueryParameter instance) =>
    <String, dynamic>{
      'site': instance.site,
      'actorId': instance.actorId,
      'movieTypeId': instance.movieTypeId,
      'isDislike': instance.isDislike,
      'isStar': instance.isStar,
      'hasPicture': instance.hasPicture,
      'hasMovieFile': instance.hasMovieFile,
      'distinct': instance.distinct,
      'q': instance.q,
      'sorting': instance.sorting,
    };
