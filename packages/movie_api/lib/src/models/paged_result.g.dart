// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paged_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagedResult _$PagedResultFromJson(Map<String, dynamic> json) => PagedResult(
      total: json['Total'] as int,
      maxNo: json['MaxNo'] as int,
      size: json['Size'] as int,
      items: json['Items'] as List<dynamic>? ?? const [],
    );

Map<String, dynamic> _$PagedResultToJson(PagedResult instance) =>
    <String, dynamic>{
      'Total': instance.total,
      'MaxNo': instance.maxNo,
      'Size': instance.size,
      'Items': instance.items,
    };
