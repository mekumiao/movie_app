import 'package:dio/dio.dart';
import 'package:movie_api/movie_api.dart';
import 'package:remote_movie_api/src/api_helper.dart';

class WorkerRequestFailure implements Exception {}

class RemoteWorkerApi extends WorkerApi {
  Dio _dio() {
    final dio = ApiHelper.getInstance();
    dio.options.validateStatus = (status) => status == 202;
    return dio;
  }

  @override
  Future<void> cancelMovieFileSyncWorker() async {
    try {
      await _dio().put('worker/cancelMovieFileSyncWorker');
    } on DioError {
      throw WorkerRequestFailure();
    }
  }

  @override
  Future<void> cancelMoviePictureSyncWorker() async {
    try {
      await _dio().put('worker/cancelMoviePictureSyncWorker');
    } on DioError {
      throw WorkerRequestFailure();
    }
  }

  @override
  Future<void> cancelMovieSyncWorker() async {
    try {
      await _dio().put('worker/cancelMovieSyncWorker');
    } on DioError {
      throw WorkerRequestFailure();
    }
  }

  @override
  Future<WorkerMessage> getMovieFileSyncMessage() async {
    try {
      final resp = await ApiHelper.dio.get('worker/movieFileSyncWorkerMessage');
      final output = OutputResult.fromJson(resp.data);
      final result = WorkerMessage.fromJson(output.result);
      return result;
    } on DioError {
      throw WorkerRequestFailure();
    }
  }

  @override
  Future<WorkerMessage> getMoviePictureSyncMessage() async {
    try {
      final resp = await ApiHelper.dio.get('worker/moviePictureSyncWorkerMessage');
      final output = OutputResult.fromJson(resp.data);
      final result = WorkerMessage.fromJson(output.result);
      return result;
    } on DioError {
      throw WorkerRequestFailure();
    }
  }

  @override
  Future<WorkerMessage> getMovieSyncMessage() async {
    try {
      final resp = await ApiHelper.dio.get('worker/movieSyncWorkerMessage');
      final output = OutputResult.fromJson(resp.data);
      final result = WorkerMessage.fromJson(output.result);
      return result;
    } on DioError {
      throw WorkerRequestFailure();
    }
  }

  @override
  Future<void> runMovieFileSyncWorker() async {
    try {
      await _dio().put('worker/runMovieFileSyncWorker');
    } on DioError {
      throw WorkerRequestFailure();
    }
  }

  @override
  Future<void> runMoviePictureSyncWorker() async {
    try {
      await _dio().put('worker/runMoviePictureSyncWorker');
    } on DioError {
      throw WorkerRequestFailure();
    }
  }

  @override
  Future<void> runMovieSyncWorker(MovieSyncPayload payload) async {
    try {
      await _dio().put('worker/runMovieSyncWorker', data: payload);
    } on DioError {
      throw WorkerRequestFailure();
    }
  }
}
