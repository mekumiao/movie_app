// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingState _$SettingStateFromJson(Map<String, dynamic> json) => SettingState(
      mode: $enumDecodeNullable(_$ThemeModeEnumMap, json['Mode']) ??
          ThemeMode.system,
      languageCode: json['LanguageCode'] as String? ?? '',
      hostIndex: json['HostIndex'] as int? ?? 0,
      hosts: (json['Hosts'] as List<dynamic>?)
              ?.map((e) => HostConfigDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          defaultHosts,
      user: json['User'] == null
          ? const UserDto()
          : UserDto.fromJson(json['User'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SettingStateToJson(SettingState instance) =>
    <String, dynamic>{
      'Mode': _$ThemeModeEnumMap[instance.mode],
      'LanguageCode': instance.languageCode,
      'HostIndex': instance.hostIndex,
      'Hosts': instance.hosts,
      'User': instance.user,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
