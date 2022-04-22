import 'package:json_annotation/json_annotation.dart';

part 'movie_add.g.dart';

@JsonSerializable()
class MovieAdd {
  const MovieAdd({
    required this.name,
    required this.remark,
  });

  factory MovieAdd.fromJson(Map<String, dynamic> json) => _$MovieAddFromJson(json);

  final String name;
  final String remark;

  Map<String, dynamic> toJson() => _$MovieAddToJson(this);
}
