// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host_config_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HostConfigDto _$HostConfigDtoFromJson(Map<String, dynamic> json) =>
    HostConfigDto(
      id: json['Id'] as String? ?? '',
      name: json['Name'] as String? ?? '',
      host: json['Host'] as String? ?? '',
      remark: json['Remark'] as String? ?? '',
    );

Map<String, dynamic> _$HostConfigDtoToJson(HostConfigDto instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Host': instance.host,
      'Remark': instance.remark,
    };
