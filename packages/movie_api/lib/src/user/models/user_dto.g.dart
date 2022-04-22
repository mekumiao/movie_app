// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      fullname: json['Fullname'] as String? ?? '',
      nickname: json['Nickname'] as String? ?? '',
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'Fullname': instance.fullname,
      'Nickname': instance.nickname,
    };
