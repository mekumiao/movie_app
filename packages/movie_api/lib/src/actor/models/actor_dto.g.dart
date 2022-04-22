// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actor_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActorDto _$ActorDtoFromJson(Map<String, dynamic> json) => ActorDto(
      id: json['Id'] as String? ?? '',
      name: json['Name'] as String? ?? '',
      picture: json['Picture'] as String? ?? '',
      pictureURL: json['PictureURL'] as String? ?? '',
      pictureDiskURL: json['PictureDiskURL'] as String? ?? '',
      remark: json['Remark'] as String? ?? '',
    );

Map<String, dynamic> _$ActorDtoToJson(ActorDto instance) => <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Picture': instance.picture,
      'PictureURL': instance.pictureURL,
      'PictureDiskURL': instance.pictureDiskURL,
      'Remark': instance.remark,
    };
