import 'package:dio/dio.dart';
import 'package:movie_api/movie_api.dart';

import 'api_helper.dart';

class MovieFileRequestFailure implements Exception {}

class MovieFileNotFoundFailure implements Exception {}

class RemoteMovieFileApi extends MovieFileApi {
  @override
  Future<MovieFileDto> get(String id) async {
    try {
      final resp = await ApiHelper.dio.get('moviefile/$id');
      final output = OutputResult.fromJson(resp.data);
      if (output.result == null) {
        throw MovieFileNotFoundFailure();
      }
      return MovieFileDto.fromJson(output.result);
    } on DioError {
      throw MovieFileRequestFailure();
    }
  }

  @override
  Future<List<MovieFileDto>> getList({
    int? no,
    int? size,
    String? q,
    Map<String, dynamic> parameters = const {},
  }) async {
    try {
      final resp = await ApiHelper.dio.get('moviefile/',
          queryParameters: Map.of(parameters)
            ..addAll({
              'no': no,
              'q': q,
              'size': size,
            }));
      final output = OutputResult.fromJson(resp.data);
      if (output.result == null) {
        return const [];
      }
      final items = (output.result as List).map((e) => MovieFileDto.fromJson(e)).toList();
      return items;
    } on DioError {
      throw MovieFileRequestFailure();
    }
  }
}
