import 'package:dio/dio.dart';
import 'package:movie_api/movie_api.dart';
import 'package:remote_movie_api/src/api_helper.dart';

class HostConfigRequestFailure implements Exception {}

class HostConfigNotFoundFailure implements Exception {}

class HostConfigAddFailure implements Exception {}

class RemoteHostConfigApi extends HostConfigApi {
  @override
  Future<String> add(HostConfigAdd input) async {
    try {
      final resp = await ApiHelper.dio.post('hostConfig', data: input);
      final output = OutputResult.fromJson(resp.data);
      final result = output.result as String;
      return result;
    } on DioError {
      throw HostConfigRequestFailure();
    }
  }

  @override
  Future<int> delete(String id) async {
    try {
      final resp = await ApiHelper.dio.delete('hostConfig/$id');
      final output = OutputResult.fromJson(resp.data);
      final result = output.result as int;
      return result;
    } on DioError {
      throw HostConfigRequestFailure();
    }
  }

  @override
  Future<HostConfigDto> get(String id) async {
    try {
      final resp = await ApiHelper.dio.get('hostConfig/$id');
      final output = OutputResult.fromJson(resp.data);
      if (output.result == null) {
        throw HostConfigNotFoundFailure();
      }
      final result = HostConfigDto.fromJson(output.result);
      return result;
    } on DioError {
      throw HostConfigRequestFailure();
    }
  }

  @override
  Future<List<HostConfigDto>> getList({
    String? q,
    int? no,
    int? size,
    String? sorting,
  }) async {
    try {
      final resp = await ApiHelper.dio.get('hostConfig', queryParameters: {
        'q': q,
        'no': no,
        'size': size,
        'sorting': sorting,
      });
      final output = OutputResult.fromJson(resp.data);
      final result = (output.result as List).map((e) => HostConfigDto.fromJson(e)).toList();
      return result;
    } on DioError {
      throw HostConfigRequestFailure();
    }
  }

  @override
  Future<int> update(String id, HostConfigUpdate input) async {
    try {
      final resp = await ApiHelper.dio.put('hostConfig/$id', data: input);
      final output = OutputResult.fromJson(resp.data);
      final result = output.result as int;
      return result;
    } on DioError {
      throw HostConfigRequestFailure();
    }
  }
}
