// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieState _$MovieStateFromJson(Map<String, dynamic> json) => MovieState(
      no: json['No'] as int? ?? 1,
      title: json['Title'] as String? ?? '',
      queryParameter: json['QueryParameter'] == null
          ? const MovieQueryParameter()
          : MovieQueryParameter.fromJson(
              json['QueryParameter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieStateToJson(MovieState instance) =>
    <String, dynamic>{
      'No': instance.no,
      'Title': instance.title,
      'QueryParameter': instance.queryParameter,
    };
