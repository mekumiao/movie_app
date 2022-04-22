// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'output_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutputResult _$OutputResultFromJson(Map<String, dynamic> json) => OutputResult(
      code: json['Code'] as int,
      msg: json['Msg'] as String,
      result: json['Result'],
    );

Map<String, dynamic> _$OutputResultToJson(OutputResult instance) =>
    <String, dynamic>{
      'Code': instance.code,
      'Msg': instance.msg,
      'Result': instance.result,
    };
