import 'models/models.dart';

abstract class WorkerApi {
  Future<void> runMovieSyncWorker(MovieSyncPayload payload);
  Future<void> runMovieFileSyncWorker();
  Future<void> runMoviePictureSyncWorker();

  Future<void> cancelMovieSyncWorker();
  Future<void> cancelMovieFileSyncWorker();
  Future<void> cancelMoviePictureSyncWorker();

  Future<WorkerMessage> getMovieSyncMessage();
  Future<WorkerMessage> getMovieFileSyncMessage();
  Future<WorkerMessage> getMoviePictureSyncMessage();
}
