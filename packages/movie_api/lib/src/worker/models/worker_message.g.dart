// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkerMessage _$WorkerMessageFromJson(Map<String, dynamic> json) =>
    WorkerMessage(
      state: json['State'] as int? ?? 0,
      message: json['Message'] as String? ?? '',
      progress: json['Progress'] as int? ?? 0,
    );

Map<String, dynamic> _$WorkerMessageToJson(WorkerMessage instance) =>
    <String, dynamic>{
      'State': instance.state,
      'Message': instance.message,
      'Progress': instance.progress,
    };
