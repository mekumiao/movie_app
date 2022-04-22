// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_add.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginAdd _$LoginAddFromJson(Map<String, dynamic> json) => LoginAdd(
      username: json['Username'] as String? ?? '',
      password: json['Password'] as String? ?? '',
    );

Map<String, dynamic> _$LoginAddToJson(LoginAdd instance) => <String, dynamic>{
      'Username': instance.username,
      'Password': instance.password,
    };
