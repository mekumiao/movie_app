// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_type_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieTypeDto _$MovieTypeDtoFromJson(Map<String, dynamic> json) => MovieTypeDto(
      id: json['Id'] as String? ?? '',
      name: json['Name'] as String? ?? '',
      remark: json['Remark'] as String? ?? '',
      count: json['Count'] as int? ?? 0,
    );

Map<String, dynamic> _$MovieTypeDtoToJson(MovieTypeDto instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Remark': instance.remark,
      'Count': instance.count,
    };
