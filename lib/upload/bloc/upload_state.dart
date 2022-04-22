part of 'upload_bloc.dart';

class UploadState extends Equatable {
  const UploadState({
    this.progress = 0,
  });

  final double progress;

  UploadState copyWith({
    double? progress,
  }) {
    return UploadState(
      progress: progress ?? this.progress,
    );
  }

  @override
  List<Object> get props => [];
}
