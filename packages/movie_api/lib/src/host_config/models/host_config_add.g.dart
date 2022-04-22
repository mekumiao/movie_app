// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host_config_add.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HostConfigAdd _$HostConfigAddFromJson(Map<String, dynamic> json) =>
    HostConfigAdd(
      name: json['Name'] as String? ?? '',
      host: json['Host'] as String? ?? '',
      remark: json['Remark'] as String? ?? '',
    );

Map<String, dynamic> _$HostConfigAddToJson(HostConfigAdd instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'Host': instance.host,
      'Remark': instance.remark,
    };
