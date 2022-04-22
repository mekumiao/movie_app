import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'host_config_update.g.dart';

@JsonSerializable()
class HostConfigUpdate extends Equatable {
  const HostConfigUpdate({
    this.name = '',
    this.host = '',
    this.remark = '',
  });

  factory HostConfigUpdate.fromJson(Map<String, dynamic> json) => _$HostConfigUpdateFromJson(json);

  final String name;
  final String host;
  final String remark;

  HostConfigUpdate copyWith({
    String? name,
    String? host,
    String? remark,
  }) {
    return HostConfigUpdate(
      name: name ?? this.name,
      host: host ?? this.host,
      remark: remark ?? this.remark,
    );
  }

  Map<String, dynamic> toJson() => _$HostConfigUpdateToJson(this);

  @override
  List<Object?> get props => [name, host, remark];
}
