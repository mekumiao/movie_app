import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'apk_version_dto.g.dart';

@JsonSerializable()
class ApkVersionDto extends Equatable {
  const ApkVersionDto({
    this.id = '',
    this.fileURL = '',
    this.name = '',
    this.versionCode = 0,
    this.versionName = '',
    this.fileDiskURL = '',
    this.isActived = false,
    this.downloads = 0,
    this.remark = '',
  });

  factory ApkVersionDto.fromJson(Map<String, dynamic> json) => _$ApkVersionDtoFromJson(json);

  final String id;
  final String fileURL;
  final String name;
  final int versionCode;
  final String versionName;
  final String fileDiskURL;
  final bool isActived;
  final int downloads;
  final String remark;

  ApkVersionDto copyWith({
    String? id,
    String? fileURL,
    String? name,
    int? versionCode,
    String? versionName,
    String? fileDiskURL,
    bool? isActived,
    int? downloads,
    String? remark,
  }) {
    return ApkVersionDto(
      id: id ?? this.id,
      fileURL: fileURL ?? this.fileURL,
      name: name ?? this.name,
      versionCode: versionCode ?? this.versionCode,
      versionName: versionName ?? this.versionName,
      fileDiskURL: fileDiskURL ?? this.fileDiskURL,
      isActived: isActived ?? this.isActived,
      downloads: downloads ?? this.downloads,
      remark: remark ?? this.remark,
    );
  }

  Map<String, dynamic> toJson() => _$ApkVersionDtoToJson(this);

  @override
  List<Object?> get props => [id, versionCode];
}
