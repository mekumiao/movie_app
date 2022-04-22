part of 'worker_bloc.dart';

enum WorkerStatus { initial, loading, refreshed, failure }

class WorkerState extends Equatable {
  const WorkerState({
    this.movieMessage = const WorkerMessage(),
    this.movieFileMessage = const WorkerMessage(),
    this.moviePictureMessage = const WorkerMessage(),
    this.status = WorkerStatus.initial,
  });

  double get movieProgress => movieMessage.progress / 100.0;
  double get movieFileProgress => movieFileMessage.progress / 100.0;
  double get moviePictureProgress => moviePictureMessage.progress / 100.0;

  final WorkerMessage movieMessage;
  final WorkerMessage movieFileMessage;
  final WorkerMessage moviePictureMessage;
  final WorkerStatus status;

  WorkerState copyWith({
    WorkerMessage? movieMessage,
    WorkerMessage? movieFileMessage,
    WorkerMessage? moviePictureMessage,
    WorkerStatus? status,
  }) {
    return WorkerState(
      movieMessage: movieMessage ?? this.movieMessage,
      movieFileMessage: movieFileMessage ?? this.movieFileMessage,
      moviePictureMessage: moviePictureMessage ?? this.moviePictureMessage,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [movieMessage, movieFileMessage, moviePictureMessage, status];
}
