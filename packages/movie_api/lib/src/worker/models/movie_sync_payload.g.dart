// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_sync_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieSyncPayload _$MovieSyncPayloadFromJson(Map<String, dynamic> json) =>
    MovieSyncPayload(
      no: json['No'] as int? ?? 1,
      total: json['Total'] as int? ?? 10,
      site: json['Site'] as int? ?? 1,
    );

Map<String, dynamic> _$MovieSyncPayloadToJson(MovieSyncPayload instance) =>
    <String, dynamic>{
      'No': instance.no,
      'Total': instance.total,
      'Site': instance.site,
    };
