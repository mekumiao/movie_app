import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'host_config_dto.g.dart';

@JsonSerializable()
class HostConfigDto extends Equatable {
  const HostConfigDto({
    this.id = '',
    this.name = '',
    this.host = '',
    this.remark = '',
  });

  factory HostConfigDto.fromJson(Map<String, dynamic> json) => _$HostConfigDtoFromJson(json);

  final String id;
  final String name;
  final String host;
  final String remark;

  HostConfigDto copyWith({
    String? id,
    String? name,
    String? host,
    String? remark,
  }) {
    return HostConfigDto(
      id: id ?? this.id,
      name: name ?? this.name,
      host: host ?? this.host,
      remark: remark ?? this.remark,
    );
  }

  Map<String, dynamic> toJson() => _$HostConfigDtoToJson(this);

  @override
  List<Object?> get props => [id, name, host, remark];
}
