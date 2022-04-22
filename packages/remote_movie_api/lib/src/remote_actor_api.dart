import 'package:dio/dio.dart';
import 'package:movie_api/movie_api.dart';
import 'package:remote_movie_api/src/api_helper.dart';

class ActorRequestFailure implements Exception {}

class ActorNotFoundFailure implements Exception {}

class ActorAddFailure implements Exception {}

class RemoteActorApi extends ActorApi {
  @override
  Future<String> add({
    required String name,
    required String remark,
    String? picturePath,
  }) async {
    final data = <String, dynamic>{
      'name': name,
      'remark': remark,
    };
    if (picturePath != null) {
      final picture = MultipartFile.fromFile(picturePath);
      data['files'] = picture;
    }
    final formData = FormData.fromMap(data);
    try {
      final resp = await ApiHelper.dio.post('actor', data: formData);
      final output = OutputResult.fromJson(resp.data);
      final result = output.result as String;
      if (result.isEmpty) {
        throw ActorAddFailure();
      }
      return result;
    } on DioError {
      throw ActorRequestFailure();
    }
  }

  @override
  Future<int> delete(String id) async {
    try {
      final resp = await ApiHelper.dio.delete('actor/$id');
      final output = OutputResult.fromJson(resp.data);
      final result = output.result as int;
      return result;
    } on DioError {
      throw ActorRequestFailure();
    }
  }

  @override
  Future<ActorDto> get(String id) async {
    try {
      final resp = await ApiHelper.dio.get('actor/$id');
      final output = OutputResult.fromJson(resp.data);
      if (output.result == null) {
        throw ActorNotFoundFailure();
      }
      final result = ActorDto.fromJson(output.result);
      return result;
    } on DioError {
      throw ActorRequestFailure();
    }
  }

  @override
  Future<List<ActorDto>> getList({
    String? q,
    int? no,
    int? size,
    String? sorting,
  }) async {
    try {
      final resp = await ApiHelper.dio.get('actor', queryParameters: {
        'q': q,
        'no': no,
        'size': size,
        'sorting': sorting,
      });
      final output = OutputResult.fromJson(resp.data);
      final result = (output.result as List).map((e) => ActorDto.fromJson(e)).toList();
      return result;
    } on DioError {
      throw ActorRequestFailure();
    }
  }

  @override
  Future<int> update(
    String id, {
    required String name,
    required String remark,
    String? picturePath,
  }) async {
    final data = <String, dynamic>{
      'name': name,
      'remark': remark,
    };
    if (picturePath != null) {
      final picture = MultipartFile.fromFile(picturePath);
      data['files'] = picture;
    }
    final formData = FormData.fromMap(data);
    try {
      final resp = await ApiHelper.dio.put('actor/$id', data: formData);
      final output = OutputResult.fromJson(resp.data);
      final result = output.result as int;
      return result;
    } on DioError {
      throw ActorRequestFailure();
    }
  }
}
