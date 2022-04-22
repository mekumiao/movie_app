import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'host_config_add.g.dart';

@JsonSerializable()
class HostConfigAdd extends Equatable {
  const HostConfigAdd({
    this.name = '',
    this.host = '',
    this.remark = '',
  });

  factory HostConfigAdd.fromJson(Map<String, dynamic> json) => _$HostConfigAddFromJson(json);

  final String name;
  final String host;
  final String remark;

  HostConfigAdd copyWith({
    String? name,
    String? host,
    String? remark,
  }) {
    return HostConfigAdd(
      name: name ?? this.name,
      host: host ?? this.host,
      remark: remark ?? this.remark,
    );
  }

  Map<String, dynamic> toJson() => _$HostConfigAddToJson(this);

  @override
  List<Object?> get props => [name, host, remark];
}
