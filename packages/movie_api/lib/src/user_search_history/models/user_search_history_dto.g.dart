// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_search_history_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSearchHistoryDto _$UserSearchHistoryDtoFromJson(
        Map<String, dynamic> json) =>
    UserSearchHistoryDto(
      id: json['Id'] as String? ?? '',
      userId: json['UserId'] as String? ?? '',
      value: json['Value'] as String? ?? '',
      tag: json['Tag'] as String? ?? '',
    );

Map<String, dynamic> _$UserSearchHistoryDtoToJson(
        UserSearchHistoryDto instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'UserId': instance.userId,
      'Value': instance.value,
      'Tag': instance.tag,
    };
