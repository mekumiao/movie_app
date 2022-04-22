part of 'worker_bloc.dart';

abstract class WorkerEvent extends Equatable {
  const WorkerEvent();

  @override
  List<Object> get props => [];
}

class WorkerRefreshed extends WorkerEvent {
  const WorkerRefreshed();
}

class MovieSyncRun extends WorkerEvent {
  const MovieSyncRun();
}

class MovieFileSyncRun extends WorkerEvent {
  const MovieFileSyncRun();
}

class MoviePictureSyncRun extends WorkerEvent {
  const MoviePictureSyncRun();
}
