import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_sync_payload.g.dart';

@JsonSerializable()
class MovieSyncPayload extends Equatable {
  const MovieSyncPayload({
    this.no = 1,
    this.total = 10,
    this.site = 1,
  });

  factory MovieSyncPayload.fromJson(Map<String, dynamic> json) => _$MovieSyncPayloadFromJson(json);

  final int no;
  final int total;
  final int site;

  Map<String, dynamic> toJson() => _$MovieSyncPayloadToJson(this);

  @override
  List<Object?> get props => [no, total, site];
}
