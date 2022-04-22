import 'package:dio/dio.dart';
import 'package:movie_api/movie_api.dart';

import 'api_helper.dart';

class MovieRequestFailure implements Exception {}

class MovieNotFoundFailure implements Exception {}

class MovieSavedFailure implements Exception {}

class RemoteMovieApi extends MovieApi {
  @override
  Future<int> dislike(String id, bool isDislike) async {
    try {
      final resp = await ApiHelper.dio.put('movie/$id/dislike', data: isDislike);
      final output = OutputResult.fromJson(resp.data);
      final result = output.result as int;
      return result;
    } on DioError {
      throw MovieRequestFailure();
    }
  }

  @override
  Future<MovieDto> get(String id) async {
    try {
      final resp = await ApiHelper.dio.get('movie/$id');
      final output = OutputResult.fromJson(resp.data);
      if (output.result == null) {
        throw MovieNotFoundFailure();
      }
      return MovieDto.fromJson(output.result);
    } on DioError {
      throw MovieRequestFailure();
    }
  }

  @override
  Future<int> star(String id, bool isStar) async {
    try {
      final resp = await ApiHelper.dio.put('movie/$id/star', data: isStar);
      final output = OutputResult.fromJson(resp.data);
      final result = output.result as int;
      return result;
    } on DioError {
      throw MovieRequestFailure();
    }
  }

  @override
  Future<int> getTotal(MovieQueryParameter? queryParameter) async {
    try {
      final resp = await ApiHelper.dio.get(
        'movie/',
        queryParameters: {'size': 1, 'hasTotal': true}..addAll(queryParameter?.toJson() ?? {}),
      );
      final output = OutputResult.fromJson(resp.data);
      if (output.result == null) {
        return 0;
      }
      final paged = PagedResult.fromJson(output.result);
      return paged.total;
    } on DioError {
      throw MovieRequestFailure();
    }
  }

  @override
  Future<int> update(String id, MovieUpdate movie) async {
    try {
      final resp = await ApiHelper.dio.put('movie/$id', data: movie);
      final output = OutputResult.fromJson(resp.data);
      final result = output.result as int;
      return result;
    } on DioError {
      throw MovieRequestFailure();
    }
  }

  @override
  Future<int> delete(String id) async {
    try {
      final resp = await ApiHelper.dio.delete('movie/$id');
      final output = OutputResult.fromJson(resp.data);
      final result = output.result as int;
      return result;
    } on DioError {
      throw MovieRequestFailure();
    }
  }

  @override
  Future<List<MovieDto>> getList({int? no, int? size, MovieQueryParameter? queryParameter}) async {
    try {
      final resp = await ApiHelper.dio.get(
        'movie/',
        queryParameters: {'no': no, 'size': size}..addAll(queryParameter?.toJson() ?? {}),
      );
      final output = OutputResult.fromJson(resp.data);
      final items = (output.result as List).map((e) => MovieDto.fromJson(e)).toList();
      return items;
    } on DioError {
      throw MovieRequestFailure();
    }
  }
}
