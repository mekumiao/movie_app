import 'package:dio/dio.dart';
import 'package:movie_api/movie_api.dart';

import 'api_helper.dart';

class MovieTypeRequestFailure implements Exception {}

class MovieTypeNotFoundFailure implements Exception {}

class RemoteMovieTypeApi extends MovieTypeApi {
  @override
  Future<MovieTypeDto> get(String id) async {
    try {
      final resp = await ApiHelper.dio.get('movietype/$id');
      final output = OutputResult.fromJson(resp.data);
      if (output.result == null) {
        throw MovieTypeNotFoundFailure();
      }
      return MovieTypeDto.fromJson(output.result);
    } on DioError {
      throw MovieTypeRequestFailure();
    }
  }

  @override
  Future<List<MovieTypeDto>> getList({
    int? no,
    int? size,
    String? q,
    Map<String, dynamic> parameters = const {},
  }) async {
    try {
      final resp = await ApiHelper.dio.get('movietype/',
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
      final items = (output.result as List).map((e) => MovieTypeDto.fromJson(e)).toList();
      return items;
    } on DioError {
      throw MovieTypeRequestFailure();
    }
  }
}
