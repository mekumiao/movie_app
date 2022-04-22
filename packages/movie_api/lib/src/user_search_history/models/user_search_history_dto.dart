import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_search_history_dto.g.dart';

@JsonSerializable()
class UserSearchHistoryDto extends Equatable {
  const UserSearchHistoryDto({
    this.id = '',
    this.userId = '',
    this.value = '',
    this.tag = '',
  });

  factory UserSearchHistoryDto.fromJson(Map<String, dynamic> json) => _$UserSearchHistoryDtoFromJson(json);

  UserSearchHistoryDto copyWith({
    String? id,
    String? userId,
    String? value,
    String? tag,
  }) {
    return UserSearchHistoryDto(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      value: value ?? this.value,
      tag: tag ?? this.tag,
    );
  }

  final String id;
  final String userId;
  final String value;
  final String tag;

  Map<String, dynamic> toJson() => _$UserSearchHistoryDtoToJson(this);

  @override
  List<Object?> get props => [id, userId, value, tag];
}
