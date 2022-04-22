import 'package:json_annotation/json_annotation.dart';

part 'output_result.g.dart';

@JsonSerializable()
class OutputResult {
  const OutputResult({
    required this.code,
    required this.msg,
    this.result,
  });

  factory OutputResult.fromJson(Map<String, dynamic> json) => _$OutputResultFromJson(json);

  final int code;
  final String msg;
  final dynamic result;

  Map<String, dynamic> toJson() => _$OutputResultToJson(this);
}
