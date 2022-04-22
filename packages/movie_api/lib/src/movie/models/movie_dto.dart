import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_api/src/movie_file/models/movie_file_dto.dart';

part 'movie_dto.g.dart';

@immutable
@JsonSerializable()
class MovieDto extends Equatable {
  const MovieDto({
    this.pictureURL = '',
    this.movieFileURL = '',
    this.site = 0,
    this.name = '',
    this.pictureDiskURL = '',
    this.hasPicture = false,
    this.remark = '',
    this.actorName = '',
    this.movieFileName = '',
    this.hasMovieFile = false,
    this.resourceLink = '',
    this.movieTypeName = '',
    this.id = '',
    this.actorId,
    this.pushTime,
    this.movieFileId,
    this.movieFile,
    this.movieTypeId,
    this.isStar = false,
    this.isDislike = false,
  });

  factory MovieDto.fromJson(Map<String, dynamic> json) => _$MovieDtoFromJson(json);

  MovieDto copyWith({
    String? pictureURL,
    String? movieFileURL,
    int? site,
    String? name,
    String? pictureDiskURL,
    bool? hasPicture,
    String? remark,
    String? actorId,
    String? actorName,
    String? pushTime,
    String? movieFileId,
    MovieFileDto? movieFile,
    String? movieFileName,
    bool? hasMovieFile,
    String? resourceLink,
    String? movieTypeId,
    String? movieTypeName,
    String? id,
    bool? isStar,
    bool? isDislike,
  }) {
    return MovieDto(
      pictureURL: pictureURL ?? this.pictureURL,
      movieFileURL: movieFileURL ?? this.movieFileURL,
      site: site ?? this.site,
      name: name ?? this.name,
      pictureDiskURL: pictureDiskURL ?? this.pictureDiskURL,
      hasPicture: hasPicture ?? this.hasPicture,
      remark: remark ?? this.remark,
      actorId: actorId ?? this.actorId,
      actorName: actorName ?? this.actorName,
      pushTime: pushTime ?? this.pushTime,
      movieFileId: movieFileId ?? this.movieFileId,
      movieFile: movieFile ?? this.movieFile,
      movieFileName: movieFileName ?? this.movieFileName,
      hasMovieFile: hasMovieFile ?? this.hasMovieFile,
      resourceLink: resourceLink ?? this.resourceLink,
      movieTypeId: movieTypeId ?? this.movieTypeId,
      movieTypeName: movieTypeName ?? this.movieTypeName,
      id: id ?? this.id,
      isStar: isStar ?? this.isStar,
      isDislike: isDislike ?? this.isDislike,
    );
  }

  final String pictureURL;
  final String movieFileURL;
  final int site;
  final String name;
  final String pictureDiskURL;
  final bool hasPicture;
  final String remark;
  final String? actorId;
  final String actorName;
  final String? pushTime;
  final String? movieFileId;
  final MovieFileDto? movieFile;
  final String movieFileName;
  final bool hasMovieFile;
  final String resourceLink;
  final String? movieTypeId;
  final String movieTypeName;
  final String id;
  final bool isStar;
  final bool isDislike;

  Map<String, dynamic> toJson() => _$MovieDtoToJson(this);

  @override
  List<Object?> get props => [id, isStar, isDislike, actorId, actorName];
}
