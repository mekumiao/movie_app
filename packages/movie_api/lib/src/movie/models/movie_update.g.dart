// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieUpdate _$MovieUpdateFromJson(Map<String, dynamic> json) => MovieUpdate(
      actorName: json['ActorName'] as String? ?? '',
      remark: json['Remark'] as String? ?? '',
      pictureFileId: json['PictureFileId'] as String? ?? '0',
    );

Map<String, dynamic> _$MovieUpdateToJson(MovieUpdate instance) =>
    <String, dynamic>{
      'ActorName': instance.actorName,
      'Remark': instance.remark,
      'PictureFileId': instance.pictureFileId,
    };
