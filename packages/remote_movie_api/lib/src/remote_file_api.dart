import 'package:dio/dio.dart';
import 'package:movie_api/movie_api.dart';
import 'package:remote_movie_api/src/api_helper.dart';

class FileRequestFailure implements Exception {}

class RemoteFileApi extends FileApi {
  @override
  Future<String> add(String filePath, {String? remark}) async {
    final file = await MultipartFile.fromFile(filePath);
    final data = {'file': file, 'remark': remark};
    final formData = FormData.fromMap(data);
    try {
      final resp = await ApiHelper.dio.post('file', data: formData);
      final output = OutputResult.fromJson(resp.data);
      final result = output.result as String;
      return result;
    } on DioError {
      throw FileRequestFailure();
    }
  }
}
