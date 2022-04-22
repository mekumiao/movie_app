// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host_config_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HostConfigUpdate _$HostConfigUpdateFromJson(Map<String, dynamic> json) =>
    HostConfigUpdate(
      name: json['Name'] as String? ?? '',
      host: json['Host'] as String? ?? '',
      remark: json['Remark'] as String? ?? '',
    );

Map<String, dynamic> _$HostConfigUpdateToJson(HostConfigUpdate instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'Host': instance.host,
      'Remark': instance.remark,
    };
