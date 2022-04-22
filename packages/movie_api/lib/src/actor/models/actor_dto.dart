import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'actor_dto.g.dart';

@JsonSerializable()
class ActorDto extends Equatable {
  const ActorDto({
    this.id = '',
    this.name = '',
    this.picture = '',
    this.pictureURL = '',
    this.pictureDiskURL = '',
    this.remark = '',
  });

  factory ActorDto.fromJson(Map<String, dynamic> json) => _$ActorDtoFromJson(json);

  ActorDto copyWith({
    String? id,
    String? name,
    String? picture,
    String? pictureURL,
    String? pictureDiskURL,
    String? remark,
  }) {
    return ActorDto(
      id: id ?? this.id,
      name: name ?? this.name,
      picture: picture ?? this.picture,
      pictureURL: pictureURL ?? this.pictureURL,
      pictureDiskURL: pictureDiskURL ?? this.pictureDiskURL,
      remark: remark ?? this.remark,
    );
  }

  final String id;
  final String name;
  final String picture;
  final String pictureURL;
  final String pictureDiskURL;
  final String remark;

  Map<String, dynamic> toJson() => _$ActorDtoToJson(this);

  @override
  List<Object?> get props => [id, name, picture, pictureURL, pictureDiskURL, remark];
}
