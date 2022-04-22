// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDto _$MovieDtoFromJson(Map<String, dynamic> json) => MovieDto(
      pictureURL: json['PictureURL'] as String? ?? '',
      movieFileURL: json['MovieFileURL'] as String? ?? '',
      site: json['Site'] as int? ?? 0,
      name: json['Name'] as String? ?? '',
      pictureDiskURL: json['PictureDiskURL'] as String? ?? '',
      hasPicture: json['HasPicture'] as bool? ?? false,
      remark: json['Remark'] as String? ?? '',
      actorName: json['ActorName'] as String? ?? '',
      movieFileName: json['MovieFileName'] as String? ?? '',
      hasMovieFile: json['HasMovieFile'] as bool? ?? false,
      resourceLink: json['ResourceLink'] as String? ?? '',
      movieTypeName: json['MovieTypeName'] as String? ?? '',
      id: json['Id'] as String? ?? '',
      actorId: json['ActorId'] as String?,
      pushTime: json['PushTime'] as String?,
      movieFileId: json['MovieFileId'] as String?,
      movieFile: json['MovieFile'] == null
          ? null
          : MovieFileDto.fromJson(json['MovieFile'] as Map<String, dynamic>),
      movieTypeId: json['MovieTypeId'] as String?,
      isStar: json['IsStar'] as bool? ?? false,
      isDislike: json['IsDislike'] as bool? ?? false,
    );

Map<String, dynamic> _$MovieDtoToJson(MovieDto instance) => <String, dynamic>{
      'PictureURL': instance.pictureURL,
      'MovieFileURL': instance.movieFileURL,
      'Site': instance.site,
      'Name': instance.name,
      'PictureDiskURL': instance.pictureDiskURL,
      'HasPicture': instance.hasPicture,
      'Remark': instance.remark,
      'ActorId': instance.actorId,
      'ActorName': instance.actorName,
      'PushTime': instance.pushTime,
      'MovieFileId': instance.movieFileId,
      'MovieFile': instance.movieFile,
      'MovieFileName': instance.movieFileName,
      'HasMovieFile': instance.hasMovieFile,
      'ResourceLink': instance.resourceLink,
      'MovieTypeId': instance.movieTypeId,
      'MovieTypeName': instance.movieTypeName,
      'Id': instance.id,
      'IsStar': instance.isStar,
      'IsDislike': instance.isDislike,
    };
