import 'package:movie_api/movie_api.dart';

class WorkerRepository {
  const WorkerRepository({
    required WorkerApi workerApi,
  }) : _workerApi = workerApi;

  final WorkerApi _workerApi;

  Future<void> runMovieSync(MovieSyncPayload payload) async {
    return _workerApi.runMovieSyncWorker(payload);
  }

  Future<void> runMovieFileSync() async {
    return _workerApi.runMovieFileSyncWorker();
  }

  Future<void> runMoviePictureSync() async {
    return _workerApi.runMoviePictureSyncWorker();
  }

  Future<void> cancelMovieSync() async {
    return _workerApi.cancelMovieSyncWorker();
  }

  Future<void> cancelMovieFileSync() async {
    return _workerApi.cancelMovieFileSyncWorker();
  }

  Future<void> cancelMoviePictureSync() async {
    return _workerApi.cancelMoviePictureSyncWorker();
  }

  Future<WorkerMessage> getMovieSyncMessage() async {
    return _workerApi.getMovieSyncMessage();
  }

  Future<WorkerMessage> getMovieFileSyncMessage() async {
    return _workerApi.getMovieFileSyncMessage();
  }

  Future<WorkerMessage> getMoviePictureSyncMessage() async {
    return _workerApi.getMoviePictureSyncMessage();
  }
}
