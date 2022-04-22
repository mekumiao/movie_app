import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_api/src/movie/models/movie_dto.dart';

part 'movie_file_dto.g.dart';

@immutable
@JsonSerializable()
class MovieFileDto extends Equatable {
  const MovieFileDto({
    this.id = '',
    this.url = '',
    this.diskURL = '',
    this.fileName = '',
    this.movie,
  });

  factory MovieFileDto.fromJson(Map<String, dynamic> json) => _$MovieFileDtoFromJson(json);

  final String id;
  @JsonKey(name: 'URL')
  final String url;
  final String fileName;
  final String diskURL;
  final MovieDto? movie;

  Map<String, dynamic> toJson() => _$MovieFileDtoToJson(this);

  @override
  List<Object?> get props => [id];
}
