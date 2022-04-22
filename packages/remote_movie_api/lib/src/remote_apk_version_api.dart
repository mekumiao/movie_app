import 'package:dio/dio.dart';
import 'package:movie_api/movie_api.dart';
import 'package:remote_movie_api/src/api_helper.dart';

class ApkVersionRequestFailure implements Exception {}

class RemoteApkVersionApi extends ApkVersionApi {
  @override
  Future<ApkVersionDto?> latest() async {
    try {
      final resp = await ApiHelper.dio.get('apkVersion/latest');
      final output = OutputResult.fromJson(resp.data);
      if (output.result == null) {
        return null;
      }
      final result = ApkVersionDto.fromJson(output.result);
      return result;
    } on DioError {
      throw ApkVersionRequestFailure();
    }
  }
}
