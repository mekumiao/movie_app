// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_movie_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchMovieState _$SearchMovieStateFromJson(Map<String, dynamic> json) =>
    SearchMovieState(
      q: json['Q'] as String? ?? '',
      parameters: json['Parameters'] as Map<String, dynamic>? ?? const {},
      allowDelete: json['AllowDelete'] as bool? ?? false,
      histories: (json['Histories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      types: (json['Types'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      movieTypeId: json['MovieTypeId'] as String? ?? '',
    );

Map<String, dynamic> _$SearchMovieStateToJson(SearchMovieState instance) =>
    <String, dynamic>{
      'Q': instance.q,
      'AllowDelete': instance.allowDelete,
      'Parameters': instance.parameters,
      'Histories': instance.histories,
      'Types': instance.types,
      'MovieTypeId': instance.movieTypeId,
    };
