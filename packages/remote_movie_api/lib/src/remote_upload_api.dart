import 'package:dio/dio.dart';
import 'package:movie_api/movie_api.dart';

import 'api_helper.dart';

class UploadRequestFailure implements Exception {}

class RemoteUploadApi {
  Future<String> upload(
    String filePath, {
    CancelToken? cancelToken,
    void Function(int count, int total)? progressCallback,
  }) async {
    final file = await MultipartFile.fromFile(filePath);
    final data = {'file': file};
    final formData = FormData.fromMap(data);
    try {
      final resp = await ApiHelper.dio.post(
        'upload',
        data: formData,
        cancelToken: cancelToken,
        onSendProgress: (int count, int total) {
          progressCallback?.call(count, total);
        },
      );
      final output = OutputResult.fromJson(resp.data);
      final result = output.result as String;
      return result;
    } on DioError {
      throw UploadRequestFailure();
    }
  }
}
