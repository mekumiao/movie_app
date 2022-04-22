// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apk_version_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApkVersionDto _$ApkVersionDtoFromJson(Map<String, dynamic> json) =>
    ApkVersionDto(
      id: json['Id'] as String? ?? '',
      fileURL: json['FileURL'] as String? ?? '',
      name: json['Name'] as String? ?? '',
      versionCode: json['VersionCode'] as int? ?? 0,
      versionName: json['VersionName'] as String? ?? '',
      fileDiskURL: json['FileDiskURL'] as String? ?? '',
      isActived: json['IsActived'] as bool? ?? false,
      downloads: json['Downloads'] as int? ?? 0,
      remark: json['Remark'] as String? ?? '',
    );

Map<String, dynamic> _$ApkVersionDtoToJson(ApkVersionDto instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'FileURL': instance.fileURL,
      'Name': instance.name,
      'VersionCode': instance.versionCode,
      'VersionName': instance.versionName,
      'FileDiskURL': instance.fileDiskURL,
      'IsActived': instance.isActived,
      'Downloads': instance.downloads,
      'Remark': instance.remark,
    };
