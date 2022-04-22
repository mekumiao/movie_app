import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_type_dto.g.dart';

@immutable
@JsonSerializable()
class MovieTypeDto extends Equatable {
  const MovieTypeDto({
    this.id = '',
    this.name = '',
    this.remark = '',
    this.count = 0,
  });

  factory MovieTypeDto.fromJson(Map<String, dynamic> json) => _$MovieTypeDtoFromJson(json);

  final String id;
  final String name;
  final String remark;
  final int count;

  Map<String, dynamic> toJson() => _$MovieTypeDtoToJson(this);

  @override
  List<Object?> get props => [id];
}
