import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_update.g.dart';

@JsonSerializable()
class MovieUpdate extends Equatable {
  const MovieUpdate({
    this.actorName = '',
    this.remark = '',
    this.pictureFileId = '0',
  });

  factory MovieUpdate.fromJson(Map<String, dynamic> json) => _$MovieUpdateFromJson(json);

  final String actorName;
  final String remark;
  final String pictureFileId;

  MovieUpdate copyWith({
    String? actorName,
    String? remark,
    String? pictureFileId,
  }) {
    return MovieUpdate(
      actorName: actorName ?? this.actorName,
      remark: remark ?? this.remark,
      pictureFileId: pictureFileId ?? this.pictureFileId,
    );
  }

  Map<String, dynamic> toJson() => _$MovieUpdateToJson(this);

  @override
  List<Object?> get props => [actorName, remark, pictureFileId];
}
