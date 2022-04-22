import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto extends Equatable {
  const UserDto({
    this.fullname = '',
    this.nickname = '',
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  final String fullname;
  final String nickname;

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  @override
  List<Object?> get props => [fullname, nickname];
}
