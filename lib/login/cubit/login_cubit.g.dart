// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginState _$LoginStateFromJson(Map<String, dynamic> json) => LoginState(
      status: $enumDecodeNullable(_$LoginStatusEnumMap, json['Status']) ??
          LoginStatus.initial,
      loginAdd: json['LoginAdd'] == null
          ? const LoginAdd()
          : LoginAdd.fromJson(json['LoginAdd'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginStateToJson(LoginState instance) =>
    <String, dynamic>{
      'Status': _$LoginStatusEnumMap[instance.status],
      'LoginAdd': instance.loginAdd,
    };

const _$LoginStatusEnumMap = {
  LoginStatus.initial: 'initial',
  LoginStatus.loading: 'loading',
  LoginStatus.success: 'success',
  LoginStatus.failure: 'failure',
};
