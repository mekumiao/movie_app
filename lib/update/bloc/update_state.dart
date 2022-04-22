part of 'update_bloc.dart';

enum UpdateStateStatus { initial, loading, needUpdate, aleadyLatest, failure }

class UpdateState extends Equatable {
  const UpdateState({
    this.currentVersionName = '',
    this.status = UpdateStateStatus.initial,
    this.apkVersion = const ApkVersionDto(),
  });

  final String currentVersionName;
  final UpdateStateStatus status;
  final ApkVersionDto apkVersion;

  UpdateState copyWith({
    String? currentVersionName,
    UpdateStateStatus? status,
    ApkVersionDto? apkVersion,
  }) {
    return UpdateState(
      currentVersionName: currentVersionName ?? this.currentVersionName,
      status: status ?? this.status,
      apkVersion: apkVersion ?? this.apkVersion,
    );
  }

  @override
  List<Object> get props => [status, apkVersion, currentVersionName];
}
