import 'package:dio/dio.dart';
import 'package:movie_api/movie_api.dart';

import 'api_helper.dart';

class UserSearchHistoryRequestFailure implements Exception {}

class RemoteUserSearchHistoryApi extends UserSearchHistoryApi {
  @override
  Future<int> delete(String tag, {String? value}) async {
    try {
      final resp = await ApiHelper.dio.delete('userSearchHistory/$tag/', queryParameters: {'value': value});
      final output = OutputResult.fromJson(resp.data);
      final result = output.result as int;
      return result;
    } on DioError {
      throw UserSearchHistoryRequestFailure();
    }
  }

  @override
  Future<List<UserSearchHistoryDto>> getList({
    int? no,
    int? size,
    String? q,
    String? tag,
    bool? distinct,
  }) async {
    try {
      final resp = await ApiHelper.dio.get(
        'userSearchHistory/',
        queryParameters: {
          'no': no,
          'q': q,
          'tag': tag,
          'size': size,
          'distinct': distinct,
        },
      );
      final output = OutputResult.fromJson(resp.data);
      if (output.result == null) {
        return const [];
      }
      final items = (output.result as List).map((e) => UserSearchHistoryDto.fromJson(e)).toList();
      return items;
    } on DioError {
      throw UserSearchHistoryRequestFailure();
    } catch (e) {
      rethrow;
    }
  }
}
