import 'package:json_annotation/json_annotation.dart';

part 'paged_result.g.dart';

@JsonSerializable()
class PagedResult {
  const PagedResult({
    required this.total,
    required this.maxNo,
    required this.size,
    this.items = const [],
  });

  factory PagedResult.fromJson(Map<String, dynamic> json) => _$PagedResultFromJson(json);

  final int total;
  final int maxNo;
  final int size;
  final List<dynamic> items;

  Map<String, dynamic> toJson() => _$PagedResultToJson(this);
}
