// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_file_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieFileDto _$MovieFileDtoFromJson(Map<String, dynamic> json) => MovieFileDto(
      id: json['Id'] as String? ?? '',
      url: json['URL'] as String? ?? '',
      diskURL: json['DiskURL'] as String? ?? '',
      fileName: json['FileName'] as String? ?? '',
      movie: json['Movie'] == null
          ? null
          : MovieDto.fromJson(json['Movie'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieFileDtoToJson(MovieFileDto instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'URL': instance.url,
      'FileName': instance.fileName,
      'DiskURL': instance.diskURL,
      'Movie': instance.movie,
    };
